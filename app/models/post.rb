class Post < ApplicationRecord
  validates_presence_of [:description, :title]

  belongs_to :user
  has_many :replies
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships
end
