require "json"
require "http/status"

require "./types"

module CA
  struct Error
    property body : ErrorBody = {} of String => JSON::Any
    property status_code : HTTP::Status

    def initialize(body : String | ErrorBody, @status_code)
      @body = body.is_a?(String) ? {"message" => JSON::Any.new(body)} : body
    end

    def self.simple_message(message : String)
      instance = Error.new(message, HTTP::Status::BAD_REQUEST)
      instance
    end

    def self.bad_request(body)
      instance = Error.new(body, HTTP::Status::BAD_REQUEST)
      instance
    end

    def self.server_error(body)
      instance = Error.new(body, HTTP::Status::INTERNAL_SERVER_ERROR)
      instance
    end

    def self.unauthorized(message : String)
      instance = Error.new(message, HTTP::Status::UNAUTHORIZED)
      instance
    end

    def self.login_timeout(message : String)
      instance = Error.new(message, HTTP::Status.new(440))
      instance
    end

    def to_json
      @body.to_json
    end
  end
end
