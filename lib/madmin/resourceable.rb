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

      def scopes
        class_variable_get(:@@scopes)
      rescue NameError
        []
      end

      def scope(*args)
        validate_scopes!(args)

        fresh_scopes = scopes << args

        class_variable_set(:@@scopes, fresh_scopes.flatten.uniq)
      end

      def formable_fields
        fields.select { |_key, value| value[:form] }
      end

      def form_all_fields!
        class_variable_set(:@@form_all_fields, true)
      end

      def form_all_fields?
        class_variable_get(:@@form_all_fields)
      rescue NameError
        false
      end

      def name
        super.to_s.split("::").last.underscore.split("_").reverse.drop(1).join(" ").capitalize
      end

      def showable_fields
        fields.select { |_key, value| value[:show] }
      end

      def show_all_fields!
        class_variable_set(:@@show_all_fields, true)
      end

      def show_all_fields?
        class_variable_get(:@@show_all_fields)
      rescue NameError
        false
      end

      def show_in_menu?
        true
      end

      def index_fields
        fields.select { |_key, value| value[:index] }
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
          show: has_options ? options.fetch(:show, true) : false,
          index: has_options ? options.fetch(:index, false) : false,
          type: args[1],
          form: has_options ? options.fetch(:form, false) : false,
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

      def validate_scopes!(args)
        args.each do |arg|
          unless name.constantize.respond_to?(arg)
            raise UndefinedScopeError,
              ".#{arg} is not a valid scope on #{name}"
          end
        end
      end
    end
  end
end
