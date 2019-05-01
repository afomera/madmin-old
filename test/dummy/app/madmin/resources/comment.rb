module Madmin
  class Resources
    class Comment
      include Madmin::Resourceable

      field :id, Madmin::Field::Number, index: true
      field :commentable, Madmin::Field::Polymorphic, index: true, form: true, display_value: :title
      field :body, Madmin::Field::Text, index: true, form: true
    end
  end
end
