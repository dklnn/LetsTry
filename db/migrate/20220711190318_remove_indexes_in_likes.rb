class RemoveIndexesInLikes < ActiveRecord::Migration[7.0]
  def change
    remove_index :likes, name: 'index_likes_on_likeable_id'
    remove_index :likes, name: 'index_likes_on_user_id'
  end
end
