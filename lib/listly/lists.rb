#module Listly
require 'active_support'
#
module ListParent
  #
  # - creates items of the passed in item_class with the passed in type_prefix for code and name for list items
  def all_list_items(type_prefix, item_class, list_items_hash = {})
    list_items = []
    list_items_hash.each do |item|
      data = {}
      item.each{ |key, value| data["#{type_prefix}_#{key}"] = "#{value}" }
      list_items << Module.const_get("Lists::#{item_class}").new(data)
    end
    list_items
  end

  def list_item_name(all_items, code_field, name_field, list_item_code)
    name = ''
    all_items.map do |item|
      if (item.send code_field) == list_item_code
        name = item.send name_field
      end
    end
    name
  end

  class MyListType
    attr_accessor :list_hash # - this is for convenience methods in Rails

    # - dynamically create the properties from the passed in hash at runtime
    define_method :initialize do |args|
      @list_hash = args

      args.each do |name, value|
        instance_variable_get("@#{name}")
        instance_variable_set("@#{name}", value)
        self.class_eval("attr_reader :#{name}")
      end
    end

    # - these are for convenience methods in Rails i.e. make lists behave like AR objects
    def [](key)
      list_hash[key.to_s]
    end

    def []=(key, value)
      list_hash[key.to_s] = value
    end
  end

end
#
module Lists
  #
  # List Class Names as Constants
  TEST1_TYPE = :test1_types_hash
  TEST2_TYPE = :test2_types_hash
  #

  # some convenience methods to create the list modules and class from the CONSTANT
  class << self
    # Returns a hash of class names to hash storage details as sym.
    def list_name_constants
      self.constants.each_with_object({}) do |name, hash|
        # Ignore any class constants
        next if (storage_location = Lists.const_get(name)).is_a?(Module)
        hash[name] = storage_location
      end
    end

    # Returns a module name from a constant name.
    def module_name_for_list_name(name)
      module_name = name.to_s.titleize.gsub(' ', '')
    end

    def class_name_for_item_name(name)
      class_name = name.to_s.titleize.gsub(' ', '')
    end
  end
end
#
# as this file is loaded each List Module and internal item Class is dynamically created!
#
Lists.list_name_constants.each do |name, store_hash|
  list_module = Module.new
  new_module_name = Lists.module_name_for_list_name(name)
  # - add the new module to the list of constants!
  list_module.module_eval do
    include ListParent

    define_method(:storage_location) { store_hash }

    define_method("all_#{name.to_s.underscore.pluralize}") {
      all_list_items(name.to_s.underscore.to_sym,
        "#{new_module_name}::My#{new_module_name}", I18n.t("#{store_hash}"))
    }

    define_method("#{name.to_s.underscore}_name") {
      list_item_name(Module.const_get("all_#{name.to_s.underscore.pluralize}"),
        "#{name.to_s.underscore}_code".to_sym, "#{name.to_s.underscore}_name".to_sym,
        list_item_code)
    }
  end
  # - create the internal class that will hold the list data (hash)
  klass = Class.new(ListParent::MyListType)
  klass.send(:define_method, :code) { code }

  # - add this class to the module constants
  class_name = "My#{new_module_name}"
  list_module.const_set(class_name, klass)
  Lists.const_set(new_module_name, list_module)
end

#end
