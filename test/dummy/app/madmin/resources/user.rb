module Madmin
  class Resources
    class User
      include Madmin::Resourceable

      scope :active
      scope :inactive

      field :id, Madmin::Field::Number, index: true, label: "ID"
      field :email, Madmin::Field::Email, index: true, form: true, label: "Customer email"
      field :first_name, Madmin::Field::Text, index: true, form: true
      field :last_name, Madmin::Field::Text, index: true, form: true
      field :active, Madmin::Field::CheckBox, index: true, form: true
    end
  end
end
