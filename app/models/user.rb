class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :replies
  has_many :collects
  has_many :collect_posts, through: :collects, source: :post

  def admin?
    self.role == "admin"
  end
end
