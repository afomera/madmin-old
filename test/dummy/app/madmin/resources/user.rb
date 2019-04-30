module Madmin
  class Resources
    class User
      include Madmin::Resourceable

      scope :active
      scope :inactive
      scope :by_name

      field :id, Madmin::Field::Number, index: true, form: true
      field :email, Madmin::Field::Email, index: true, form: true, label: "Customer email"
      field :first_name, Madmin::Field::Text, index: true, form: true
      field :last_name, Madmin::Field::Text, index: true, form: true
      field :active, Madmin::Field::CheckBox, index: true, form: true
      # field :cars, Madmin::Field::HasMany, form: true
      field :car, Madmin::Field::HasOne, form: true
    end
  end
end
