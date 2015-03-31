require 'coveralls'
Coveralls.wear!
#
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
#
ENV["RAILS_ENV"] ||= 'test'
#
require 'rspec'
require 'rspec/given'
require 'rack'
#
#require 'rails'
require 'active_support'
require 'active_support/core_ext'
#
require 'listly'
#
# - this loads the actual lists
require 'listly/load_lists'
# - then run the load process that is normally handled by rails!
LoadLists.load
