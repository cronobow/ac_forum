class Collect < ApplicationRecord
  validates_uniqueness_of :user_id, :scope => :post_id

  belongs_to :user
  belongs_to :post
end
