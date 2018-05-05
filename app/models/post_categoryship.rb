class PostCategoryship < ApplicationRecord
  validates_uniqueness_of :post_id, :scope => :category_id

  belongs_to :post
  belongs_to :category
end
