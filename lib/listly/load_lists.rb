module LoadLists
  def self.load
    #
    # this will dynamically include the configured Constants module..
    #
    Listly.include_constants_module
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
      klass = Class.new(Listly::BaseList::MyListType)
      klass.send(:define_method, :code) { code }

      # - add this class to the module constants
      class_name = "My#{new_module_name}"
      list_module.const_set(class_name, klass)

      Listly.const_set(new_module_name, list_module)
    end
  end
end
