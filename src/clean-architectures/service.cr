require "http/status"

require "./either"
require "./error"
require "./types"

module CA
  class AssertionError < Exception
    property body : String | ErrorBody
    property status : HTTP::Status

    def initialize(@body, @status)
    end
  end

  abstract class Service(Request, Result)
    abstract def validate(request : Request)

    abstract def execute(request : Request)

    def call(request : Request)
      validation = validate(request)
      if !validation.nil?
        return validation
      end
      execute(request)
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
