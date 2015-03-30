#
module Listly
  #
  # List Class Names as Constants
  include Listly::ListConstants
  #
  # some convenience methods to create the list modules and class from the CONSTANT
  class << self
    # Returns a hash of class names to hash storage details as sym.
    def list_name_constants
      self.constants.each_with_object({}) do |name, hash|
        # Ignore any class constants
        next if (storage_location = Listly.const_get(name)).is_a?(Module)
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
Listly.list_name_constants.each do |name, store_hash|
  list_module = Module.new
  new_module_name = Listly.module_name_for_list_name(name)
  # - add the new module to the list of constants!
  list_module.module_eval do
    include Listly::BaseList

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
  #klass = Class.new(ListParent::MyListType)
  klass = Class.new(Listly::BaseList::MyListType)
  klass.send(:define_method, :code) { code }

  # - add this class to the module constants
  class_name = "My#{new_module_name}"
  list_module.const_set(class_name, klass)
  Listly.const_set(new_module_name, list_module)
end
