class AddStateToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :invite, :string, default: 'pending'
  end
end
