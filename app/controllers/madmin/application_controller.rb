require_dependency "madmin/resources"

module Madmin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :validate_resources

    helper_method :resource_types

    private

    def resource_types
      @resource_types ||= Madmin::Resources.gather.map do |type|
        Object.const_get("::Madmin::Resources::#{type}Resource")
      end
    end

    # Taking a peek at all the resources will raise an error if one isn't found.
    # Let's inform the user if we can't find a resource no matter what page
    # they're on. This should fail to prevent surprises at run time.
    def validate_resources
      Madmin::Resources.all
    end
  end
end
