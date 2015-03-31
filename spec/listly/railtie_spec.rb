#
require 'spec_helper_railtie'
require 'i18n'
#
# This module is what in a real app would be placed in the lib folder
# and contain the constants to be turned into list objects
module DummyTestConstants
  TEST3_TYPE = :test3_types_hash
  TEST4_TYPE = :test4_types_hash
end
#
require 'listly'
#
require 'spec_helper_load_application'
#
require 'listly/load_lists'
#
class Dummy3Test
  include Listly::Test3Type
end
class Dummy4Test
  include Listly::Test4Type
end
#
describe Listly::Railtie do
  before do
    @test_hash = [
      {'code' => 'nsw', 'name' => 'New South Wales'},
      {'code' => 'qld', 'name' => 'Queensland'},
      {'code' => 'sa', 'name' => 'South Australia'}
    ]
    expect(I18n).to receive(:t).with('test3_types_hash').and_return(@test_hash)
    expect(I18n).to receive(:t).with('test4_types_hash').and_return(@test_hash)

    @test3_types = Dummy3Test.new.all_test3_types
    @test4_types = Dummy4Test.new.all_test4_types
  end

  it 'after initialisation the TEST3_TYPE constant should be turned into a list' do
    test_obj = @test3_types[0]

    expect(test_obj).to respond_to(:test3_type_code)
    expect(test_obj).to respond_to(:test3_type_name)
    expect(Dummy3Test.new).to respond_to(:all_test3_types)
  end

  it 'after initialisation the TEST4_TYPE constant should be turned into a list' do
    test_obj = @test4_types[0]

    expect(test_obj).to respond_to(:test4_type_code)
    expect(test_obj).to respond_to(:test4_type_name)
    expect(Dummy4Test.new).to respond_to(:all_test4_types)
  end

  it 'after initialisation the App should have the listly constants module configured' do
    expect(Rails.application.config.listly[:listly_constants_module]).to eq :dummy_test_constants
  end
end
