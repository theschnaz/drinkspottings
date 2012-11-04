class ChangeDataTypeForDescription3 < ActiveRecord::Migration
  def up
    change_column :posts, :description, :text
  end

  def down
    change_column :posts, :description, :string
  end
end
