require "http/server"

require "./either"
require "./error"

module CA
  module ControllerExtensions
    def get_raw_body(context)
      context.request.body.not_nil!
    end

    def respond_with_either(context, either)
      if either.right?
        value = either.right
        context.put_status(200)
          .put_resp_header("Content-Type", "application/json; charset=UTF-8")
          .send_resp("{\"data\": #{value.to_json}}")
      else
        error = either.left
        context.put_status(error.not_nil!.status_code)
          .put_resp_header("Content-Type", "application/json; charset=UTF-8")
          .send_resp(error.to_json)
      end
      context
    end
  end
end
