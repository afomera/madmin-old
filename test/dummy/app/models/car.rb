class Car < ApplicationRecord
  attribute :discontinued, :boolean

  belongs_to :user
end
