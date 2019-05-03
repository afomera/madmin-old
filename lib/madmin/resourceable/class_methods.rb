module Madmin
  module Resourceable
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

        key        = args[0].to_sym
        field_type = args[1]

        # We reassign the entire list of fields to prevent
        # duplication each time the class is evaluated.
        fresh_fields = fields
        fresh_fields[key] = field_type.new(args[2].merge(key: key, model: model, resource: self))

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
      # This method exposes the underlying model.
      def model
        model_name.constantize
      end

      ##
      # This method extracts the namespace to reveal
      # the underlying models name as a string.
      def model_name
        to_s.split("Madmin::Resources::").last.to_s
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

      private

      ##
      # This method validates that a given attribute for
      # a field is provided in the correct format of
      # either a symbol or a string.
      def attribute?(attribute)
        attribute.is_a?(Symbol) || attribute.is_a?(String)
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
            "#{model_name} expected the attribute name as a symbol or string as the first argument."
        elsif !valid_type?(args.second)
          raise WrongArgumentError,
            "#{model_name} expected Madmin::Field type as the field type as the second argument."
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
          unless model.respond_to?(arg)
            raise UndefinedScopeError, ".#{arg} is not a valid scope on #{name}"
          end
        end
      end
    end
  end
end
