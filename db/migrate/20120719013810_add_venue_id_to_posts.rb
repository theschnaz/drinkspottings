class AddVenueIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :venue_id, :integer
  end
end
