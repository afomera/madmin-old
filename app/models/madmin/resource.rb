module Madmin
  class Resource
    cattr_accessor :permit_all_params
    cattr_accessor :permitted_params

    def self.editable_fields(*args)
      self.permitted_params = args
    end

    def self.permit_all_fields!
      self.permit_all_params = true
    end

    def self.permit_all_params?
      permit_all_params || false
    end
  end
end
