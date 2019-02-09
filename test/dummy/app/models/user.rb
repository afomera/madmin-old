class User < ApplicationRecord
  include Madmin::Concerns::Resourceable

  def self.permitted_params
    [:email, :first_name, :last_name]
  end
end
