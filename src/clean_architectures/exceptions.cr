require "grip"

module CA
  class APIError < Grip::Exceptions::Base
    property body : Hash(String, String)

    def initialize(@body, @status_code)
      super @body.to_s
    end

    def to_s
      @body.to_s
    end

    def self.simple_message(message : String)
      instance = APIError.allocate
      instance.initialize({"message" => message}, HTTP::Status::BAD_REQUEST)
      instance
    end

    def self.bad_request(body : Hash(String, String))
      instance = APIError.allocate
      instance.initialize(body, HTTP::Status::BAD_REQUEST)
      instance
    end

    def self.server_error(body : Hash(String, String))
      instance = APIError.allocate
      instance.initialize(body, HTTP::Status::INTERNAL_SERVER_ERROR)
      instance
    end

    def self.unauthorized(message : String)
      instance = APIError.allocate
      instance.initialize({"message" => message}, HTTP::Status::UNAUTHORIZED)
      instance
    end

    def self.login_timeout(message : String)
      instance = APIError.allocate
      instance.initialize({"message" => message}, HTTP::Status.new(440))
      instance
    end
  end
end
