module Madmin
  class Field
    module Associatable
      class << self
        def included(_base)
          attr_reader :association_class
          attr_reader :association_display_value
          attr_reader :association_foreign_key
          attr_reader :association_scope
        end
      end

      def initialize(args)
        super(args)
        implement_association!
      end

      def association_collection
        association_class.send(association_scope)
      end

      def association_id_for(resource)
        value_for(resource).id
      end

      def association_id_or_blank_for(resource)
        value_for(resource).try(:id)
      end

      def association_param
        ActiveModel::Naming.param_key(association_class)
      end

      def association_slug
        Object.const_get("::Madmin::Resources::#{association_class}").new.slug
      end

      def association_value_for(resource)
        value_for(resource).send(association_display_value)
      end

      def strong_params_keys
        [association_foreign_key]
      end

      private

      def implement_association!
        association = model.reflect_on_all_associations.find { |assc| assc.name == key }

        @association_class         = association.klass
        @association_display_value = option_or_default(:display_value, :name)
        @association_foreign_key   = association.foreign_key
        @association_scope         = :all
      end
    end
  end
end
