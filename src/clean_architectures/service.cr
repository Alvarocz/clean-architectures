require "http/status"

require "./either"
require "./error"
require "./types"

module CA
  abstract class Service(Request, Result)
    abstract def validate(request : Request)

    abstract def execute(request : Request)

    def call(request : Request) : Either(Error, Result)
      Either(Error, Request).from_success(request)
        .bind(run_validation)
        .bind(execute)
    end

    def run_validation(request : Request) : Either(Error, Request)
      response = self.validate(request)
      if response.right?
        return Either(Error, Request).from_success(request, nil)
      end
      response
    end

    # Validation step
    def ok
      Either(Error, Bool).from_success(true)
    end

    # Execute step
    def success(value : Result)
      Either(Error, Result).from_success(value)
    end

    def error(body : String | ErrorBody, status : HTTP::Status)
      Either(Error, Result).from_error(Error.new(body, status))
    end
  end
end
