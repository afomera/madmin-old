module Madmin
  module Resourceable
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def fields
        class_variable_get(:@@fields)
      rescue NameError
        {}
      end

      def field(*args)
        new_fields = fields
        new_fields[args[0]] = args[1]
        class_variable_set(:@@fields, new_fields)
        class_variable_set(:@@editable_fields, new_fields)
      end

      def editable_fields
        class_variable_get(:@@editable_fields)
      end

      def edit_all_fields!
        class_variable_set(:@@edit_all_fields, true)
      end

      def edit_all_fields?
        class_variable_get(:@@editable_fields)
      rescue NameError
        false
      end

      def read_all_fields!
        class_variable_set(:@@edit_all_fields, true)
      end

      def read_all_fields?
        class_variable_get(:@@readable_fields)
      rescue NameError
        false
      end
    end
  end
end
