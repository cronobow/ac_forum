class Post < ApplicationRecord
  validates_presence_of [:description, :title]

  belongs_to :user
  has_many :replies
  has_many :categories, through: :post_categroyships
end
