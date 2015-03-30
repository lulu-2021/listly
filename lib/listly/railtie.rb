#
module Listly
  class Railtie < Rails::Railtie
    # enable namespaced configuration in Rails environments
    config.listly = ActiveSupport::OrderedOptions.new
    #
    initializer :after_initialize do |app|
      #
      Listly.configure do |config|
        config.listly_store_location = app.config.listly[:store_location]
        config.listly_constants_module = app.config.listly[:constants_module]
      end
      #
      # here we will dynamically load the client rails app module that has the
      # constants that will be turned into lists!
      constants_module = Module.const_get(app.config.listly[:constants_module].to_s.titleize)
      Listly.include_constants_module(constants_module)
    end
  end
end
