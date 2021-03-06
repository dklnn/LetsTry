class User < ApplicationRecord
  has_many :comments, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  # self-join association of user model
  # using follow model, user realizing many-to-many connection on it's own
  # user has many user.followers though follow's table
  # & user has many user.followees though follow's table
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  # active storage association for one attached image that's called avatar
  has_one_attached :avatar, dependent: :destroy

  # after record creation call add_default_avatar method on several controller methods
  after_commit :add_default_avatar, on: %i[create update]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,
            length: { minimum: 3, maximum: 127 },
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  validates :avatar, content_type: ['image/png', 'image/jpeg']

  # public method that resizing avatar if avatar attached and attaches default avatar if not
  # NEED TO BE REFACTORED
  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '75x75!').processed
    else
      '/default_avatar.jpg'
    end
  end

  private

  # method that attaches defaul avatar file from local drive
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.jpg'
          )
        ), filename: 'default_avatar.jpg',
        content_type: ['image/png', 'image/jpg']
      )
    end
  end
end
