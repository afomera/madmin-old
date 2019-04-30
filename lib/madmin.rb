require "madmin/engine"
require "madmin/resourceable"
require "madmin/resources"

module Madmin
  class NoResourcesError < StandardError; end
  class ResourceNotFoundError < StandardError; end
  class WrongArgumentError < StandardError; end
  class UndefinedScopeError < StandardError; end
  class ScopeWithArgumentsError < StandardError; end

  # Your code goes here...
end
