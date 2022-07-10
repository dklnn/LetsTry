class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  belongs_to :user, optional: true

  validates :title, :body, presence: true
  validates :title, length: { in: 3..125 }
  validates :body, length: { in: 3..2000 }
  validates :image, content_type: ['image/png', 'image/jpeg']
end


