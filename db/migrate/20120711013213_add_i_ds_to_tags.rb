class AddIDsToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
    add_column :tags, :drink_id, :integer
  end
end
