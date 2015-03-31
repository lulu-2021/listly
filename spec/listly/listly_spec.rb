require 'spec_helper'

describe Listly do
  it 'has a version number' do
    expect(Listly::VERSION).not_to be nil
  end

  it 'has a method that: can return a module name from a constant ' do
    expect(Listly).to respond_to(:module_name_for_list_name)
  end

  it 'has a method that: can return a class name from a constant ' do
    expect(Listly).to respond_to(:class_name_for_item_name)
  end

  it 'has a method to generate Listly Modules with Internal Classes from a list of its own constants' do
    expect(Listly).to respond_to(:list_name_constants)
  end

  it 'can return a module name from a constant' do
    name = :test_type
    expect(Listly.module_name_for_list_name(name)).to eq 'TestType'
  end

  it 'can return a class name from a constant' do
    name = :test2_state
    expect(Listly.class_name_for_item_name(name)).to eq 'Test2State'
  end

  it 'generates Listly Modules with Internal Classes from a list of constants' do
    
  end
end
