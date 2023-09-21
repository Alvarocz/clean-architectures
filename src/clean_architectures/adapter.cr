require "./types"

module CA
  class Adapter
    property config : ConfigHash
    # For documentation-only purposes:
    property name : String = ""
    property description : String = ""

    def initialize(@config={} of String => ConfigValue,
                   @name="",
                   @description="")
    end
  end
end

