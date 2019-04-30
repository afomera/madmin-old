module Madmin
  class Resources
    # TODO: link to documentation in error message.
    def self.gather
      all
    rescue NoMethodError
      raise NoResourcesError,
        "You must define an array of resources as `self.all` in lib/madmin/resources.rb"
    rescue NameError => e
      raise ResourceNotFoundError, "Madmin cannot locate the resource #{e.name}."
    end
  end
end
