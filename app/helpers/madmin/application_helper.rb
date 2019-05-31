module Madmin
  module ApplicationHelper
    def available_resources
      @available_resources ||= Madmin::Resources.gather.map { |model| madmin_resource_for(model: model) }
    end

    def madmin_resource_for(model:)
      Object.const_get("::Madmin::Resources::#{model}").new
    end

    def pages
      Madmin::Pages.all
    end
  end
end
