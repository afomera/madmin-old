module Madmin
  class Resources
    class CarResource
      include Madmin::Resourceable

      field :year, Madmin::Field::Number, table: true, write: true
      field :make, Madmin::Field::Text, table: true, write: true
      field :model, Madmin::Field::Text, table: true, write: true
      field :discontinued, Madmin::Field::CheckBox, write: true, read: false
    end
  end
end
