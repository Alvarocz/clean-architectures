require "http/status"

module CA
  class Error
    property status : HTTP::Status
  end
end