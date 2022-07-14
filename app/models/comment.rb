class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  # polymorphic likes, comment and post models has marked as likeable
  # so like model understand this and automaticly associates likeable with them
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, length: { minimum: 3, maximum: 125 }
end
