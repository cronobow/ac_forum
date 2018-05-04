class Post < ApplicationRecord
  validates_presence_of [:description, :title]

  belongs_to :user
  has_many :replies
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships

  enum privacy: {
    public:      1, # 公開
    onlyfriend:  2, # 好友限定
    onlyme:      3, # 僅限自己
  }
end
