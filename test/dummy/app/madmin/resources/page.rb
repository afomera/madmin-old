module Madmin
  module Resources
    class Page
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, index: true, label: "ID"
      field :title, Madmin::Field::Text, index: true, form: true
      field :body, Madmin::Field::Text, form: true
      field :comments, Madmin::Field::HasMany, form: true
    end
  end
end
