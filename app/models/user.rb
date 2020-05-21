class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :folders, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_folders, through: :likes, source: :folder

  # フォロー機能の設定
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id  
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  mount_uploader :avatar, ImageUploader

  # すでにフォローしているかを確認するメソッド
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # すでにいいねしているか確認するメソッド
  def already_liked?(folder)
    likes.exists?(folder_id: folder.id)
  end
end
