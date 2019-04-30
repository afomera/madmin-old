module Madmin
  class Resources
    class CarResource
      include Madmin::Resourceable

      field :year, Madmin::Field::Number, index: true, form: true
      field :make, Madmin::Field::Text, index: true, form: true
      field :model, Madmin::Field::Text, index: true, form: true
      field :discontinued, Madmin::Field::CheckBox, form: true, show: false
      # 👇 Must match association in model
      field :user, Madmin::Field::BelongsTo, index: true, form: true, scope: :active
    end
  end
end
