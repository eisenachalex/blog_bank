class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.string :category1
      t.string :category2
      t.string :category3
      t.timestamps
    end
  end
end
