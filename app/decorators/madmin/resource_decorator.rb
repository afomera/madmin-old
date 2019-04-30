module Madmin
  class ResourceDecorator < SimpleDelegator
    delegate :formable_fields, to: :madmin_resource
    delegate :form_all_fields?, to: :madmin_resource
    delegate :showable_fields, to: :madmin_resource
    delegate :show_all_fields?, to: :madmin_resource
    delegate :index_fields, to: :madmin_resource

    def initialize(resource)
      @resource = resource
      super
    end

    def fields
      madmin_resource.fields.map { |key, field| instantiate_field(key, field) }
    end

    def index_fields
      madmin_resource.index_fields.map { |key, field| instantiate_field(key, field) }
    end

    def madmin_resource
      Object.const_get("::Madmin::Resources::#{name}Resource")
    end

    def name
      resource.class.name
    end

    private

    attr_reader :resource

    def instantiate_field(key, field)
      field[:type].new(key: key, field: field, resource: self)
    end
  end
end
