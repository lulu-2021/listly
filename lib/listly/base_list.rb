#
module Listly
  #
  module BaseList
    #
    # - creates items of the passed in item_class with the passed in type_prefix for code and name for list items
    def all_list_items(type_prefix, item_class, list_items_hash = {})
      list_items = []
      list_items_hash.each do |item|
        data = {}
        item.each{ |key, value| data["#{type_prefix}_#{key}"] = "#{value}" }
        list_items << Module.const_get(item_class).new(data)
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
end
