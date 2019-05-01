##
# This module is the heart of a Madmin Resource.
# When included into a resource class, the
# resource is given a DSL for registering
# fields, scopes, and more.
module Madmin
  module Resourceable
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    ##
    # This module extends methods into class methods on the resource.
    module ClassMethods
      ##
      # This method is a wrapper for the class variable fields.
      # In the event there is no field defined yet, we rescue
      # NameError and return an empty hash to begin the
      # population of the fields class variable.
      def fields
        class_variable_get(:@@fields)
      rescue NameError
        {}
      end

      ##
      # This becomes a DSL for adding a field into the fields class variable.
      # It is responsible for validating and parsing the arguments before
      # placing them into the fields class variable.
      def field(*args)
        validate_arguments!(args)

        # We reassign the entire list of fields to prevent
        # duplication each time the class is evaluated.
        fresh_fields = fields
        fresh_fields[args[0].to_sym] = field_from_arguments(args)

        class_variable_set(:@@fields, fresh_fields)
      end

      ##
      # This method is a wrapper for the class variable scopes.
      # In the event there is no scope defined yet, we rescue
      # NameError and return an empty array to begin the
      # population of the scopes class variable.
      def scopes
        class_variable_get(:@@scopes)
      rescue NameError
        []
      end

      ##
      # This becomes a DSL for adding a field into the scopes class variable.
      # It is responsible for validating and parsing the arguments before
      # placing them into the scopes class variable.
      def scope(*args)
        validate_scopes!(args)

        # We reassign the entire list of scopes to prevent
        # duplication each time the class is evaluated.
        fresh_scopes = scopes << args

        class_variable_set(:@@scopes, fresh_scopes.flatten.uniq)
      end

      ##
      # This method returns a list of fields where
      # the form option is truthy.
      def formable_fields
        fields.select { |_key, value| value[:form] }
      end

      ##
      # This method, when used in the resource, sets all fields
      # to be used when the form partial is rendered.
      def form_all_fields!
        class_variable_set(:@@form_all_fields, true)
      end

      ##
      # This method exposes a convenient way to see if all fields
      # for a resource should be available in a form partial.
      def form_all_fields?
        class_variable_get(:@@form_all_fields)
      rescue NameError
        false
      end

      ##
      # This methods exposes the underlying resource's name
      # in a way humans can enjoy and understand.
      def friendly_name
        name.split("::").join(" ")
      end

      ##
      # This method returns a list of fields where
      # the index option is truthy.
      def index_fields
        fields.select { |_key, value| value[:index] }
      end

      ##
      # This method exposes the underlying model.
      def model
        name.constantize
      end

      ##
      # This method extracts the namespace to reveal
      # the underlying models name as a string.
      def name
        super.to_s.split("Madmin::Resources::").last.to_s
      end

      ##
      # This method, when used in the resource, sets all fields
      # to be used when the show partial is rendered.
      def showable_fields
        fields.select { |_key, value| value[:show] }
      end

      ##
      # This method exposes a convenient way to see if all fields
      # for a resource should be available in a show partial.
      def show_all_fields!
        class_variable_set(:@@show_all_fields, true)
      end

      ##
      # This method exposes a convenient way to see if all fields
      # for a resource should be available in a show partial.
      def show_all_fields?
        class_variable_get(:@@show_all_fields)
      rescue NameError
        false
      end

      ##
      # This method exposes a way to control if the
      # resource should visible in the menu.
      def show_in_menu?
        true
      end

      ##
      # This method affords us the ability to have a
      # consistently rendered slug for a resource.
      def slug
        ActiveModel::Naming.route_key(name.constantize)
      end

      private

      ##
      # This method validates that a given attribute for
      # a field is provided in the correct format of
      # either a symbol or a string.
      def attribute?(attribute)
        attribute.is_a?(Symbol) || attribute.is_a?(String)
      end

      ##
      # This, overtly long method, generates a hash representing
      # a field inside the application. It is responsible for
      # taking the list of options and assigning them to
      # the field and subsequently providing defaults
      # if none are present.
      def field_from_arguments(args)
        options       = args.last
        has_options   = options.is_a?(Hash)
        default_label = label_from_attribute(args[0])

        fields = {
          form: has_options ? options.fetch(:form, false) : false,
          index: has_options ? options.fetch(:index, false) : false,
          label: has_options ? options.fetch(:label, default_label) : default_label,
          show: has_options ? options.fetch(:show, true) : false,
          type: args[1],
        }

        # In the event the field is an association, we assign
        # extra attributes to repesent the association.
        if args[1].association?
          association = name.constantize.reflect_on_all_associations.find { |association| association.name == args[0] }
          fields[:foreign_class] = association.klass
          fields[:foreign_display_value] = has_options ? options.fetch(:display_value, :name) : :name
          fields[:foreign_key] = association.foreign_key
          fields[:foreign_scope] = :all
        end

        # In the event the field is polymoprhic, we assign
        # extra attributes to repesent the polymorphism.
        if args[1].polymorphic?
          fields[:foreign_display_value] = has_options ? options.fetch(:display_value, :name) : :name
          fields[:foreign_scope] = :all
        end

        # In the event the field is a select, we assign
        # extra attributes to repesent the select type.
        if args[1].select?
          fields[:select_options] = has_options ? options.fetch(:collection, []) : []
        end

        fields
      end

      ##
      # This method takes an attribute and converts it
      # into a human readable format for form labels.
      def label_from_attribute(attribute)
        attribute.to_s.humanize
      end

      ##
      # We want to make sure a provided type is
      # registered within our system.
      def valid_type?(type)
        type.to_s.deconstantize == Madmin::Field.to_s
      end

      ##
      # This method looks at the first two arguments (attribute, type)
      # and performs their prospective validations. If either
      # validation fails, a WrongArgumentError is raised.
      def validate_arguments!(args)
        if !attribute?(args.first)
          raise WrongArgumentError,
            "#{name} expected the attribute name as a symbol or string as the first argument."
        elsif !valid_type?(args.second)
          raise WrongArgumentError,
            "#{name} expected Madmin::Field type as the field type as the second argument."
        end
      end

      ##
      # This method looks at a given scope(s) and validates
      # the scope exists on the underlying model.
      #
      # Rails scopes are defined as class methods as the
      # class is evaluated, requiring this method
      # of performing the validation.
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
