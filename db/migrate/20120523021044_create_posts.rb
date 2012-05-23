class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	  t.string :name
	  t.string :description
	  t.integer :posted_by
	  t.has_attached_file :photo
      t.timestamps
    end
  end
end
