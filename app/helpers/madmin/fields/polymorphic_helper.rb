module Madmin
  module Fields
    module PolymorphicHelper
      def polymorphic_id(field)
        "#{field.key}_id"
      end

      def polymorphic_models(type)
        all_resources = Madmin::Resources.all.map { |r| Madmin::ResourceDecorator.new(r) }

        polymorphic_resources = all_resources.select { |resource|
          associations = resource.model.reflect_on_all_associations
          associations.select { |a| a.options.dig(:as) === type }.any?
        }

        polymorphic_resources.map(&:model)
      end

      def polymorphic_options_for_selected_type(form:, field:)
        options_from_collection_for_select(
          form.object.send(polymorphic_type(field)).constantize.send(field.foreign_scope),
          :id,
          field.foreign_display_value,
          form.object.send(polymorphic_id(field))
        )
      end

      def polymorphic_relationship_exists?(form:, field:)
        form.object.send(polymorphic_type(field)) && form.object.send(polymorphic_id(field))
      end

      def polymorphic_type(field)
        "#{field.key}_type"
      end
    end
  end
end
