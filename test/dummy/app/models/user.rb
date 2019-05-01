class User < ApplicationRecord
  attribute :alias, :string

  has_many :posts

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :by_name, ->(name) { where(first_name: name) }

  def name
    "#{first_name} #{last_name}"
  end

  def title
    "Mr. #{first_name}"
  end
end
