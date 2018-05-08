class Post < ApplicationRecord
  validates_presence_of [:description, :title]

  belongs_to :user, counter_cache: true
  has_many :replies
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships
  has_many :collects

  enum privacy: {
    all_user:     1, # 公開
    only_friend:  2, # 好友限定
    only_me:      3, # 僅限自己
  }

  scope :published, -> { where( draft: false ) }

end
