require 'kaminari'

class Post < ApplicationRecord
  paginates_per 3

  has_many :comments, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  belongs_to :user

  validates :body, presence: true
  validates :title, length: { maximum: 125 }
  validates :body, length: { in: 3..2000 }
  validates :image, content_type: ['image/png', 'image/jpeg']

  def image_resized
    image.variant(resize: '750x750!').processed if image.attached?
  end
end
