#
require 'spec_helper'
#
require 'i18n'
#
class DummyStateList
  include Listly::Test1Type
end
#
describe 'Test1 Type List' do
  before do
    @test1_type_hash = [
      {'code' => 'nsw', 'name' => 'New South Wales'},
      {'code' => 'qld', 'name' => 'Queensland'},
      {'code' => 'sa', 'name' => 'South Australia'}
    ]
    expect(I18n).to receive(:t).with('test1_types_hash').and_return(@test1_type_hash)

    @test1_types = DummyStateList.new.all_test1_types
  end

  it 'should return a list of address type objects' do
    expect(@test1_types).to be_a(Array)

    @test1_types.each do |item|
      expect(item).to be_a(Listly::Test1Type::MyTest1Type)
    end
  end

  it 'should include nsw, qld and sa states' do
    types_arr = ['nsw', 'qld', 'sa']
    @test1_types.each do |item|
      expect(types_arr).to include(item[:test1_type_code])
    end
  end

  it 'should include nsw, qld and sa states from attr_reader' do
    types_arr = ['nsw', 'qld', 'sa']
    @test1_types.each do |item|
      expect(types_arr).to include(item.test1_type_code)
    end
  end

  it 'should include New South Wales, Queensland and South Australia as state names' do
    names_arr = ['New South Wales', 'Queensland', 'South Australia']
    @test1_types.each do |item|
      expect(names_arr).to include(item[:test1_type_name])
    end
  end

  it 'should include New South Wales, Queensland and South Australia as state names from attr_reader' do
    names_arr = ['New South Wales', 'Queensland', 'South Australia']
    @test1_types.each do |item|
      expect(names_arr).to include(item.test1_type_name)
    end
  end
end
