class Post < ApplicationRecord
  validates_presence_of [:description, :title]

  belongs_to :user
  has_many :replies
end
