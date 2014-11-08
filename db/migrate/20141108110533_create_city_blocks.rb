class CreateCityBlocks < ActiveRecord::Migration
  def change
    create_table :city_blocks do |t|
      t.integer :ip_start, :null => false
      t.integer :ip_end,   :null => false
      t.integer :loc_id,   :null => false

      t.timestamps

      t.index [:ip_start, :ip_end]
    end
  end
end
