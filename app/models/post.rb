class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user, optional: true

  validates :title, :body, presence: true
  validates :title, length: { in: 3..125 }
  validates :body, length: { in: 3..2000 }
end
