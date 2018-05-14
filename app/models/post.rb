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

  scope :published, -> {
    where( draft: false )
  }

  scope :draft, -> {
    where( draft: true )
  }

  scope :friend_post, -> (user){
    frienders = user.frienders.where('friendships.invite = ?', 'accept')
    only_friend.where('user_id in (?)', frienders.map{|x|x.id})
  }


  def collected?(user)
    self.collects.find_by(user: user)
  end

  def can_view_by?(user)

    if self.user == user
      return true
    elsif self.draft && self.user == user
      return true
    elsif self.privacy == 'only_me' && self.user == user
      return true
    elsif self.privacy == 'all_user' && !self.draft
      return true
    elsif self.privacy == 'only_friend'
      self.user.friends.where('friendships.invite = ?', 'accept').include?(user)
    else
      return false
    end
  end

end
