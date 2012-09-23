class CreateSaves < ActiveRecord::Migration
  def change
    create_table :saves do |t|
      t.integer :drink_id
      t.integer :user_id

      t.timestamps
    end
  end
end
