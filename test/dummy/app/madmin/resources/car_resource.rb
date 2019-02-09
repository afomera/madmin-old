module Madmin
  class Resources
    class CarResource
      include Madmin::Resourceable

      # editable_fields :make, :model, :year
      # showable_fields :id, :make, :model, :year

      field :year, Madmin::Field::Number
    end
  end
end
