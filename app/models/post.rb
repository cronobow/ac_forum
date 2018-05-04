class Post < ApplicationRecord
  validates_presence_of [:description, :title]
  belongs_to :user
end
