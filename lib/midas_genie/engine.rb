require 'rails/engine'

module MidasGenie
  class Engine < ::Rails::Engine
    isolate_namespace MidasGenie
  end
end
