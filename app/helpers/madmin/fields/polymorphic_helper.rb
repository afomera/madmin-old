module Madmin
  module Fields
    module PolymorphicHelper
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
          form.object.send(field.polymorphic_type_param).constantize.send(field.polymorphic_scope),
          :id,
          field.polymorphic_display_value,
          form.object.send(field.polymorphic_id_param)
        )
      end
    end
  end
end
