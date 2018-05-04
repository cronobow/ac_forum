class AddPrivacyColumnToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :privacy, :integer, default: 1
  end
end
