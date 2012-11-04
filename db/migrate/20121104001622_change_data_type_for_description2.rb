class ChangeDataTypeForDescription2 < ActiveRecord::Migration
  def up
  	change_column :posts, :description, :text
  end

  def down
  end
end
