module Madmin
  class ResourceDecorator < SimpleDelegator
    delegate :editable_fields, to: :madmin_resource
    delegate :edit_all_fields?, to: :madmin_resource
    delegate :readable_fields, to: :madmin_resource
    delegate :read_all_fields?, to: :madmin_resource

    def initialize(resource)
      @resource = resource
      super
    end

    def fields
      madmin_resource.fields.map do |key, field|
        field.new(key: key, resource: self)
      end
    end

    def madmin_resource
      Object.const_get("::Madmin::Resources::#{name}Resource")
    end

    def name
      resource.class.name
    end

    private

    attr_reader :resource
  end
end
