require "grip"

require "../either"
require "../error"
require "../exceptions"

module CA
  class Controller(Error,Result)
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
    end

    def call(context : Context) : Context
      case context.request.method
      when "GET"
        get(context)
      when "POST"
        post(context)
      when "PUT"
        put(context)
      when "PATCH"
        patch(context)
      when "DELETE"
        delete(context)
      when "OPTIONS"
        options(context)
      when "HEAD"
        head(context)
      else
        raise Grip::Exceptions::MethodNotAllowed.new
      end
    end
  end

  class BaseExceptionController < Grip::Controllers::Exception
    def call(context : Context) : Context
      context.json(
        {
          "message" => context.exception.not_nil!.to_s
        }
      )
    end
  end

  class APIErrorController < Grip::Controllers::Exception
    def call(context : Context) : Context
      exception = context.exception.not_nil!.as(Exceptions::APIError)
      context.json(exception.body)
    end
  end
end
