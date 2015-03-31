#
module Listly
  #
  # some convenience methods to create the list modules and class from the CONSTANT
  class << self
    #
    # List Class Names as Constants
    def include_constants_module
      constants_module_sym = Listly.config.listly_constants_module
      constants_module_str = constants_module_sym.to_s.titleize.gsub(' ', '')
      constants_module = Module.const_get(constants_module_str) unless constants_module_str.length == 0

      if constants_module
        self.send(:include, constants_module)
      else
        self.send(:include, Listly::ListConstants)
      end
    end
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
