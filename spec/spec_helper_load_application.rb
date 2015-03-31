#
# Setup a test app
#
module TestApp
  #
  class Application < ::Rails::Application
    #
    # This is the only configuration requirement for the company_scope gem
    # i.e. set the scoping model during the Rails startup configuration
    #
    puts "\n\n Listly TestApp: Rails Starting..."
    #
    config.listly.listly_store_location = :test_hash_store
    config.listly.listly_constants_module = :dummy_test_constants
    #
  end
end
#
TestApp::Application.config.secret_token = '1234567890123456789012345678901234567890'
TestApp::Application.config.secret_key_base = '1234567890123456789012345678901234567890'
#
TestApp::Application.initialize!
#
