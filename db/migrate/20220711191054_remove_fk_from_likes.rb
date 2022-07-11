class RemoveFkFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key 'likes', 'posts', column: 'likeable_id'
  end
end
