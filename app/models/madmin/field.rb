module Madmin
  class Field
    attr_reader :foreign_class
    attr_reader :foreign_display_value
    attr_reader :foreign_key
    attr_reader :foreign_scope
    attr_reader :key
    attr_reader :label
    attr_reader :resource
    attr_reader :select_options

    def initialize(key:, field:, resource:)
      @foreign_class = field[:foreign_class]
      @foreign_key = field[:foreign_key]
      @foreign_scope = field[:foreign_scope]
      @foreign_display_value = field[:foreign_display_value]
      @key = key
      @label = field[:label]
      @resource = resource
      @select_options = field[:select_options]
    end

    def self.association?
      false
    end

    def self.polymorphic?
      false
    end

    def self.select?
      false
    end

    def formable?
      resource.form_all_fields? || key.in?(resource.formable_fields)
    end

    def name
      key.to_s.titleize
    end

    def readable?
      resource.show_all_fields? || key.in?(resource.showable_fields)
    end

    def to_partial_path
      "madmin/fields/#{self.class.to_s.split("::").last.underscore}"
    end

    def value
      resource.send(key)
    end
  end
end
