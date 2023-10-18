require "./types"

module CA
  class Repository
    property config = {} of String => ConfigValue
    # For documentation-only purposes:
    property name : String = ""
    property description : String = ""

    def initialize(@config = {} of String => ConfigValue,
                   @name = "",
                   @description = "")
    end
  end
end
