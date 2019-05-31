require_dependency "madmin/resources"

module Madmin
  class BaseController < ActionController::Base
    before_action :validate_resources

    private

    # Taking a peek at all the resources will raise an error if one isn't found.
    # Let's inform the user if we can't find a resource no matter what page
    # they're on. This should fail to prevent surprises at run time.
    def validate_resources
      Madmin::Resources.all
    end
  end
end
