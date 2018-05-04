class CreatePostCategoryships < ActiveRecord::Migration[5.1]
  def change
    create_table :post_categoryships do |t|
      t.references  :post, foreign_key: true
      t.references  :category, foreign_key: true
      t.timestamps
    end
  end
end
