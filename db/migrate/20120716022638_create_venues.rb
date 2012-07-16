class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :foursquare_id
      t.string :name
      t.string :phone
      t.string :twitter
      t.string :address
      t.string :lat
      t.string :lng
      t.integer :postalcode
      t.string :city
      t.string :state
      t.string :country
      t.string :icon
      t.string :url

      t.timestamps
    end
  end
end
