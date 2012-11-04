class ChangeDataTypeForDescription < ActiveRecord::Migration
  def up
  	change_column :posts, :description, :text, :limit => nil
  end

  def down
  	change_column :posts, :body, :description, :limit => '255'
  end
end
