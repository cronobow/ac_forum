class Post < ApplicationRecord
  validates_presence_of [:description, :title]
  mount_uploader :image, PostimageUploader


  belongs_to :user, counter_cache: true
  has_many :replies, dependent: :destroy
  has_many :post_categoryships, dependent: :destroy
  has_many :categories, through: :post_categoryships
  has_many :collects, dependent: :destroy

  enum privacy: {
    all_user:     1, # 公開
    only_friend:  2, # 好友限定
    only_me:      3, # 僅限自己
  }

  scope :published, -> { where( draft: false ) }
  scope :draft, -> { where( draft: true ) }


  def collected?(user)
    self.collects.find_by(user: user)
  end

end
