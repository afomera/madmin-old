class Car < ApplicationRecord
  attribute :discontinued, :boolean

  belongs_to :user

  def name
    "#{year} #{make} #{model}"
  end
end
