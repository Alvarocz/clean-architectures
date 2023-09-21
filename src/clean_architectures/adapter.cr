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

    def self.from_env(*vars)
      instance = Adapter.allocate
      config = {} of String => ConfigValue
      vars.each do |var|
        config[var] = ENV[var]
      end
      instance.initialize(config)
      instance
    end
  end
end

