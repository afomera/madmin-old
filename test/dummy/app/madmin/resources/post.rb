module Madmin
  class Resources
    class Post
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, index: true, label: "ID"
      field :title, Madmin::Field::Text, index: true, form: true
      field :body, Madmin::Field::Text, form: true
      field :user, Madmin::Field::BelongsTo, form: true, index: true
    end
  end
end
