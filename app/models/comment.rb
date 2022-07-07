class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 3, maximum: 125 }
end
