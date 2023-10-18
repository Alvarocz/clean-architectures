require "./types"

module CA
  class Adapter
    property config = {} of String => ConfigValue
    # For documentation-only purposes:
    property name : String = ""
    property description : String = ""

    def initialize(@config,
                   @name = "",
                   @description = "")
    end
  end
end
