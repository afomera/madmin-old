require "madmin/resourceable/class_methods"

##
# This module is the heart of a Madmin Resource.
# When included into a resource class, the
# resource is given a DSL for registering
# fields, scopes, and more.
module Madmin
  module Resourceable
    class << self
      def included(base)
        base.extend Madmin::Resourceable::ClassMethods
      end
    end

    ##
    # This method returns a list of fields where
    # the index option is truthy.
    def form_fields
      self.class.fields.values.select { |field| field.form }
    end

    ##
    # This methods exposes the underlying resource's name
    # in a way humans can enjoy and understand.
    def friendly_name
      self.class.model_name.split("::").join(" ")
    end

    ##
    # This method returns a list of fields where
    # the index option is truthy.
    def index_fields
      self.class.fields.values.select { |field| field.index }
    end

    ##
    # This method returns a list of labels for fields
    # where the index option is truthy.
    def index_headers
      index_fields.map { |field| field.label }
    end

    ##
    # This method affords us the ability to retrieve
    # a list of the scopes from the class variable.
    def scopes
      self.class.scopes
    end

    ##
    # This method exposes a way to control if the
    # resource should visible in the menu.
    def show_in_menu?
      true
    end

    ##
    # This method, when used in the resource, sets all fields
    # to be used when the show partial is rendered.
    def show_fields
      self.class.fields.values.select { |field| field.show }
    end

    ##
    # This method affords us the ability to have a
    # consistently rendered slug for a resource.
    def slug
      ActiveModel::Naming.route_key(self.class.model)
    end
  end
end
