module Madmin
  class Resources
    class Post
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, index: true, label: "ID"
      field :title, Madmin::Field::Text, index: true, form: true
      field :body, Madmin::Field::TextArea, form: true
      field :user, Madmin::Field::BelongsTo, form: true, index: true
      field :comments, Madmin::Field::HasMany, form: true
    end
  end
end
