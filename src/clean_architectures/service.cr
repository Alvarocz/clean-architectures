require "http/status"

require "./either"
require "./error"

module CA
  class Service(Request,Result)
    abstract def validate(request : Request) : Either(Error, Request)
    end

    abstract def execute(request : Request) : Either(Error, Result)
    end

    def call(request : Request) : Either(Error, Result)
      Either(Error, Request).new(nil, request)
        .bind(validate)
        .bind(execute)
    end

    def success(value : Result)
      Either(Error, Result).from_success(value)
    end

    def error(value : Error, status : HTTP::Status)
      Either(Error, Result).from_error(value)
    end
  end
end