require 'rails/engine'

module MidasGenie
  class Engine < ::Rails::Engine
    isolate_namespace MidasGenie

    config.generators do |g|
      g.test_framework :rspec, fixture: false
    end
  end
end
