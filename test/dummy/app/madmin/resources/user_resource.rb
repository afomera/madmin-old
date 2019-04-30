module Madmin
  class Resources
    class UserResource
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, index: true
      field :email, Madmin::Field::Email, index: true, form: true, label: "Customer email"
      field :first_name, Madmin::Field::Text, index: true, form: true
      field :last_name, Madmin::Field::Text, index: true, form: true
    end
  end
end
