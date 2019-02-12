class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps
      
    end
    add_index :likes, :user_id#誰がいいねしたか
    add_index :likes, :post_id
    add_index :likes, [:user_id, :post_id], unique: true#userがいいねした投稿を取り出す。
  end
end
