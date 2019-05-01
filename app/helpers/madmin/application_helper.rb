module Madmin
  module ApplicationHelper
    def madmin_resource_for(model:)
      Object.const_get("::Madmin::Resources::#{model}")
    end
  end
end
