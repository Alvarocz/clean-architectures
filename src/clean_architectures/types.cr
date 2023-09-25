require "http/status"

module CA
  alias ConfigValue = Int32 | Float32 | Bool | String

  alias ErrorBody = Hash(String, JSON::Any)
end