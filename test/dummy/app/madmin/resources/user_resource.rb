module Madmin
  class Resources
    class UserResource
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, table: true
      field :email, Madmin::Field::Email, table: true, write: true, label: "Customer email"
      field :first_name, Madmin::Field::Text, table: true, write: true
      field :last_name, Madmin::Field::Text, write: true
    end
  end
end
