module Madmin
  class Resources
    class CarResource
      include Madmin::Resourceable

      field :year, Madmin::Field::Number, write: true
      field :make, Madmin::Field::Text, write: true
      field :model, Madmin::Field::Text, write: true
    end
  end
end
