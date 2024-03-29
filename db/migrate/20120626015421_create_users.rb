class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :facebook_key
      t.string :fb_pic_square
      t.string :fb_pic_large
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
