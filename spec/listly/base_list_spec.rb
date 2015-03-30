#
require 'spec_helper'
#
require 'i18n'
#
module DummyTestStateList
  include Listly::BaseList

  def all_states
    all_list_items(:state, "#{MyState}", I18n.t('states_hash'))
  end

  def state_name(list_item_code)
    list_item_name(all_states, :state_code, :state_name, list_item_code)
  end

  def state_description(state_code)
    description = ''
    all_states.map do |s|
      if s.state_code == state_code
        description = s.state_desc
      end
    end
    description
  end

  class MyState < Listly::BaseList::MyListType; end
end

class DummyBaseListTest
  include DummyTestStateList
end
#
describe Listly::BaseList do
  before do
    @states_hash = [
      {'code' => 'nsw', 'name' => 'New South Wales'},
      {'code' => 'qld', 'name' => 'Queensland'},
      {'code' => 'sa', 'name' => 'South Australia'}
    ]
    expect(I18n).to receive(:t).with('states_hash').and_return(@states_hash)

    @base_test = DummyBaseListTest.new
    @test_list = @base_test.all_states
  end

  it 'should return a list of objects that are of the base internal type' do
    @test_list.each do |item|
      expect(item).to be_a(Listly::BaseList::MyListType)
    end
  end

  it 'should have a method for all_list_items' do
    expect(@base_test).to respond_to(:all_list_items)
  end

  it 'should have a method for list_item_name' do
    expect(@base_test).to respond_to(:list_item_name)
  end
end
