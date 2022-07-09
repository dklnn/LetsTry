class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

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

  def avatar_thumbnail 
    if avatar.attached?
      avatar.variant(resize: '150x150!').processed
    else
      '/default_avatar.jpg'
    end
  end

  private

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
