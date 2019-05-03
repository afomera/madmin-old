module Madmin
  class Field
    ##
    # This field represents a polymorphic relationship.
    class Polymorphic < Madmin::Field
      attr_reader :polymorphic_display_value
      attr_reader :polymorphic_scope

      def initialize(args)
        super(args)
        @polymorphic_display_value = option_or_default(:display_value, :name)
        @polymorphic_scope = :all
      end

      ##
      # Returns the id for the associated polymorphic record.
      def polymorphic_id_for(resource)
        value_for(resource).id
      end

      ##
      # Returns the polymorphic ID param.
      def polymorphic_id_param
        "#{key}_id".to_sym
      end

      def polymorphic_relationship_exists?(resource)
        resource.send(polymorphic_type_param) && resource.send(polymorphic_id_param)
      end

      ##
      # Returns the slug for the polymorphic resource.
      def polymorphic_slug_for(resource)
        Object.const_get("::Madmin::Resources::#{resource.send("#{key}_type")}").new.slug
      end

      ##
      # Returns the polymorphic type param.
      def polymorphic_type_param
        "#{key}_type".to_sym
      end

      ##
      # Returns the value to show in the admin
      # for the polymorphic relationship.
      def polymorphic_value_for(resource)
        value_for(resource).send(polymorphic_display_value)
      end

      ##
      # Returns the polymorphic stront params keys.
      def strong_params_keys
        [polymorphic_id_param, polymorphic_type_param]
      end
    end
  end
end
