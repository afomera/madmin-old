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

    def editable?
      resource.edit_all_fields? || key.in?(resource.editable_fields)
    end

    def readable?
      resource.read_all_fields? || key.in?(resource.readable_fields)
    end

    def value
      resource.send(key)
    end
  end
end
