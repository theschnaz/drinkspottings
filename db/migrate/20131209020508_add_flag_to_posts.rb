class AddFlagToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :flag, :string
  end
end
