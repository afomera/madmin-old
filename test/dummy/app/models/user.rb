class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_name, ->(name) { where(first_name: name) }
end
