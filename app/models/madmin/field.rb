module Madmin
  class Field
    attr_reader :key
    attr_reader :label
    attr_reader :resource

    def initialize(key:, label:, resource:)
      @key = key
      @label = label
      @resource = resource
    end

    def formable?
      resource.form_all_fields? || key.in?(resource.formable_fields)
    end

    def readable?
      resource.show_all_fields? || key.in?(resource.showable_fields)
    end

    def value
      resource.send(key)
    end
  end
end
