class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, length: { minimum: 3, maximum: 125 }
end
