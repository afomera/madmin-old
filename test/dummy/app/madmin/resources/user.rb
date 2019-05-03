module Madmin
  module Resources
    class User
      include Madmin::Resourceable

      field :id, Madmin::Field::Number
      field :email, Madmin::Field::Text
      field :first_name, Madmin::Field::Text
      field :last_name, Madmin::Field::Text
      field :active, Madmin::Field::CheckBox
      field :created_at, Madmin::Field::DateTime
      field :updated_at, Madmin::Field::DateTime
      field :encrypted_password, Madmin::Field::Text
      field :alias, Madmin::Field::Text
    end
  end
end
