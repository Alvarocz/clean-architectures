require "grip"

require "../either"
require "../error"

module CA
  class Controller(Result)
    include HTTP::Handler
    include Helpers::Singleton

    def get_raw_body(context : Context)
      context.request.body.not_nil!
    end

    def respond_with_either(context : Context, either : Either(Error,Result))
      if either.right?
        value = either.right
        context.put_status(200)
          .put_resp_header("Content-Type", "application/json; charset=UTF-8")
          .send_resp("{\"data\": #{value.to_json}}")
      else
        error = either.left
        context.put_status(error.status)
          .put_resp_header("Content-Type", "application/json; charset=UTF-8")
          .send_resp(error.to_json)
      end
      context
    end
  end

  class BaseExceptionController < Grip::Controllers::Exception
    def call(context : Context) : Context
      context.json({ "message" => context.exception.not_nil!.to_s })
    end
  end
end
