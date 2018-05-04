class Category < ApplicationRecord
  validates_presence_of :name

  has_many :posts, through: :post_categroyships, dependent: :destroy

end
