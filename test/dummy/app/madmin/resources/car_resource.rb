module Madmin
  class Resources
    class CarResource
      include Madmin::Resourceable

      field :year, Madmin::Field::Number, index: true, form: true
      field :make, Madmin::Field::Text, index: true, form: true
      field :model, Madmin::Field::Text, index: true, form: true
      field :discontinued, Madmin::Field::CheckBox, form: true, show: false
    end
  end
end
