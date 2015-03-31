#
module Listly
  class Railtie < Rails::Railtie
    #
    puts "\n\n Loading Railtie..\n\n"
    #
    # enable namespaced configuration in Rails environments
    config.listly = ActiveSupport::OrderedOptions.new
    #
    initializer :after_initialize do |app|
      #
      Listly.configure do |config|
        config.listly_store_location = app.config.listly[:listly_store_location]
        config.listly_constants_module = app.config.listly[:listly_constants_module]
      end
      #
      # dynamically load the client rails app module that has the list constants
      LoadLists.load
      Listly.include_constants_module
    end
  end
end
#
