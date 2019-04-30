class AddUserIdToCars < ActiveRecord::Migration[5.2]
  def change
    add_reference :cars, :user, foreign_key: true
  end
end
