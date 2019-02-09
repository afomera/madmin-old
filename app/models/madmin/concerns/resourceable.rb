module Madmin
  module Concerns
    module Resourceable
      extend ActiveSupport::Concern

      included do
        def self.permitted_params
          raise Madmin::MethodNotImplemented,
                "The #{name} resource is missing the class method: permitted_params.\
                 \nImplement something like this as a class method on #{name}:\
                 \n\ndef self.permitted_params\
                 \n  [:id]\
                 \nend"
        end

        def self.permit_all_params?
          false
        end
      end
    end
  end
end
