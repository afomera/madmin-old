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
        validate_arguments!(args)

        fresh_fields = fields
        fresh_fields[args[0].to_sym] = field_from_arguments(args)

        class_variable_set(:@@fields, fresh_fields)
      end

      def editable_fields
        fields.select { |_key, value| value[:write] }
      end

      def edit_all_fields!
        class_variable_set(:@@edit_all_fields, true)
      end

      def edit_all_fields?
        class_variable_get(:@@edit_all_fields)
      rescue NameError
        false
      end

      def readable_fields
        fields.select { |_key, value| value[:read] }
      end

      def read_all_fields!
        class_variable_set(:@@read_all_fields, true)
      end

      def read_all_fields?
        class_variable_get(:@@read_all_fields)
      rescue NameError
        false
      end

      def table_fields
        fields.select { |_key, value| value[:table] }
      end

      private

      def column?(column)
        column.is_a?(Symbol) || column.is_a?(String)
      end

      def field_from_arguments(args)
        options       = args.last
        has_options   = options.is_a?(Hash)
        default_label = label_from_column(args[0])

        {
          label: has_options ? options.fetch(:label, default_label) : default_label,
          read: has_options ? options.fetch(:read, true) : false,
          table: has_options ? options.fetch(:table, false) : false,
          type: args[1],
          write: has_options ? options.fetch(:write, false) : false
        }
      end

      def label_from_column(column)
        column.to_s.humanize
      end

      def valid_type?(type)
        type.to_s.deconstantize == Madmin::Field.to_s
      end

      def validate_arguments!(args)
        if !column?(args.first)
          raise WrongArgumentError,
                "#{name} expected the column name as a symbol or string as the first argument."
        elsif !valid_type?(args.second)
          raise WrongArgumentError,
                "#{name} expected Madmin::Field type as the field type as the second argument."
        end
      end
    end
  end
end
