class CreateFollowingRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :following_relationships do |t|
      t.belongs_to :follower
      t.belongs_to :followed_user

      t.timestamps
    end
    add_index :following_relationships, :follower_id unless index_exists?(:following_relationships, :follower_id)
    add_index :following_relationships, :followed_user_id unless index_exists?(:following_relationships, :followed_user_id)
  end
end
