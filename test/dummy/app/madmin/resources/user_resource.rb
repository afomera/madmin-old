module Madmin
  class Resources
    class UserResource
      include Madmin::Resourceable

      # editable_fields :email, :first_name, :last_name
      # showable_fields :id, :email, :first_name, :last_name

      field :email, Madmin::Field::Email
      field :first_name, Madmin::Field::Text
      field :last_name, Madmin::Field::Text
    end
  end
end
