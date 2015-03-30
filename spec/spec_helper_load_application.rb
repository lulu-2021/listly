#
# Setup a test app
#
#require 'rack/multi_company'
#
module TestApp
  #
  module DummyTestConstants
    TEST3_TYPE = :test3_types_hash
    TEST4_TYPE = :test4_types_hash
  end
  #
  class Application < ::Rails::Application
    #
    # This is the only configuration requirement for the company_scope gem
    # i.e. set the scoping model during the Rails startup configuration
    #
    puts "\n\n Listly TestApp: Rails Starting..."
    #
    config.listly.listly_store_location = :test_hash_store
    config.listly.constants_module = :dummy_test_constants
    #
  end
end
#
TestApp::Application.config.secret_token = '1234567890123456789012345678901234567890'
TestApp::Application.config.secret_key_base = '1234567890123456789012345678901234567890'
#
TestApp::Application.initialize!
#
