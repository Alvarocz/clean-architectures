require "./clean_architectures/adapter"
require "./clean_architectures/controller_extensions"
require "./clean_architectures/either"
require "./clean_architectures/error"
require "./clean_architectures/repository"
require "./clean_architectures/service"
require "./clean_architectures/types"

module CA
  def self.config_from_env(*vars)
    config = {} of String => ConfigValue
    vars.each do |var|
      config[var] = ENV[var]
    end
    config
  end
end
