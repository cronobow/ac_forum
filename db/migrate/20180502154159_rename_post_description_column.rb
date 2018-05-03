class RenamePostDescriptionColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :descriptione, :description
  end
end
