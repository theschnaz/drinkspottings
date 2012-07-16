class ChangeDataTypeForFoursquareId < ActiveRecord::Migration
  def up
    change_table :venues do |t|
      t.change :foursquare_id, :string
    end
  end

  def down
    change_table :venues do |t|
      t.change :foursquare_id, :integer
    end
  end
end
