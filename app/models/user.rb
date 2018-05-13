class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :posts
  has_many :replies
  has_many :collects
  has_many :collect_posts, through: :collects, source: :post
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :frienders, through: :inverse_friendships, source: :user


  def admin?
    self.role == "admin"
  end
end
