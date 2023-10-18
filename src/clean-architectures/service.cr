require "http/status"

require "./either"
require "./error"
require "./types"

class AssertionError < Exception
  def initialize(body : String | ErrorBody, status : HTTP::Status)
  end
end

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
      response = validate(request)
      if response.nil?
        return Either(Error, Request).from_success(request, nil)
      end
      response
    rescue exc : AssertionError
      error(exc.body, exc.status)
    end

    # Validation step
    def assert(assertion, body : String | ErrorBody, status : HTTP::Status)
      if !assertion
        raise AssertionError.new(body, status)
      end
    end

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
