class User < ApplicationRecord
  include Madmin::Concerns::Resourceable

  def self.permitted_params
    [:id, :first_name, :last_name]
  end
end
