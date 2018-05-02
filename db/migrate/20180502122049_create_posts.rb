class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text   :descriptione, null: false
      t.string :image
      t.boolean :draft, null: false, default: true
      t.timestamps
    end
  end
end
