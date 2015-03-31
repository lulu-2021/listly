#
require File.dirname(__FILE__) + '/listly/base_list'
require File.dirname(__FILE__) + '/listly/list_constants'
require File.dirname(__FILE__) + '/listly/lists'
require File.dirname(__FILE__) + '/listly/railtie' if defined? ::Rails::Railtie
#
# The config class allows the Rails Application to store configuration about the gem
#
module Listly
  class Config
    attr_accessor :listly_store_location, :listly_constants_module
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end
end
#
