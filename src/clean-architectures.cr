require "./clean-architectures/adapter"
require "./clean-architectures/controller_extensions"
require "./clean-architectures/either"
require "./clean-architectures/error"
require "./clean-architectures/repository"
require "./clean-architectures/service"
require "./clean-architectures/types"

module CA
  def self.config_from_env(*vars)
    config = {} of String => ConfigValue
    vars.each do |var|
      config[var] = ENV[var]
    end
    config
  end
end
