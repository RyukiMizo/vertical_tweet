class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    drop_table :posts
    
    create_table :posts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
