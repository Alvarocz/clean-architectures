require "grip"

require "../exceptions"

module CA
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
