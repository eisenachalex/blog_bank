class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :email
    t.string :username
    t.string :firstname
    t.string :lastname
    t.string :twitter_handle
    t.string :address
    t.string :password_digest
    t.timestamps
    end
  end
end
