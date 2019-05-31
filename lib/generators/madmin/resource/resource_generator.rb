require "rails/generators/named_base"
require "madmin/generator_helpers"

module Madmin
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      ATTRIBUTE_TYPE_MAPPING = {
        boolean: "Field::CheckBox",
        date: "Field::DateTime",
        datetime: "Field::DateTime",
        enum: "Field::Text",
        float: "Field::Number",
        integer: "Field::Number",
        time: "Field::DateTime",
        text: "Field::TextArea",
        string: "Field::Text",
      }

      source_root File.expand_path("../templates", __FILE__)

      def create_resource_file
        template(
          "resource.rb.erb",
          Rails.root.join("app/madmin/resources/#{file_name}.rb"),
        )
      end

      private

      def attributes
        klass.attribute_types.map { |name, attr|
          # Skip attributes related to associations
          next if ignored_attributes.include?(name)

          [name, madmin_type_for_column(attr.type)]
        }.compact
      end

      def associations
        klass.reflections.map do |name, association|
          if association.polymorphic?
            [name, "Field::Polymorphic"]
          elsif association.belongs_to?
            [name, "Field::BelongsTo"]
          elsif association.has_one?
            [name, "Field::HasOne"]
          else
            [name, "Field::HasMany"]
          end
        end
      end

      def ignored_attributes
        attrs = []

        klass.reflections.map do |name, association|
          if association.polymorphic?
            attrs += [association.foreign_key, association.foreign_type]
          elsif association.belongs_to?
            attrs += [association.foreign_key]
          end
        end

        attrs
      end

      def klass
        @klass ||= Object.const_get(class_name)
      end

      def madmin_type_for_column(column_type)
        ATTRIBUTE_TYPE_MAPPING[column_type]
      end
    end
  end
end
