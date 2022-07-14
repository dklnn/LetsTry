class Like < ApplicationRecord
  validates :user, uniqueness: { scope: %i[likeable_id likeable_type] }
  validates :likeable_id, presence: true
  validates :likeable_type, presence: true

  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
