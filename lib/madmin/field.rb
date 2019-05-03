module Madmin
  class Field
    attr_reader :form
    attr_reader :index
    attr_reader :key
    attr_reader :label
    attr_reader :model
    attr_reader :options
    attr_reader :show
    attr_reader :type

    def initialize(args)
      @key     = args[:key]
      @options = args
      @model   = args[:model]
      @label   = option_or_default(:label, label_from_attribute(key))
      @form    = option_or_default(:form, false)
      @index   = option_or_default(:index, false)
      @show    = option_or_default(:show, true)
    end

    ##
    # Returns an array of key(s) to use in strong
    # params for the resources controller.
    def strong_params_keys
      [key]
    end

    ##
    # Returns the partial path for the field type
    def to_partial_path
      "madmin/fields/#{self.class.to_s.split("Madmin::Field::").last.underscore}"
    end

    ##
    # Returns the value for a given resource
    def value_for(resource)
      resource.send(key)
    end

    private

    ##
    # This method takes an attribute and converts it
    # into a human readable format for form labels.
    def label_from_attribute(attribute)
      attribute.to_s.humanize
    end

    ##
    # This method verifies options are present
    # (as a hash).
    def options?
      options.is_a?(Hash)
    end

    ##
    # This method extracts the many option checks
    # performed when assigning field options.
    def option_or_default(key, default)
      options? ? options.fetch(key, default) : default
    end
  end
end
