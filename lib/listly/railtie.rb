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
      end
      #
      listly_store_location = Listly.config.listly_store_location
      #
    end
  end
end
