module Madmin
  class ResourceDecorator < SimpleDelegator
    def initialize(resource)
      @resource = resource
      super
    end

    def name
      resource.class.name
    end

    private

    attr_reader :resource
  end
end
