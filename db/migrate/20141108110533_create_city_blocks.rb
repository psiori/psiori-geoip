class CreateCityBlocks < ActiveRecord::Migration
  def change
    create_table :city_blocks do |t|
      t.integer :ip_start, :null => false, limit: 8
      t.integer :ip_end,   :null => false, limit: 8
      t.integer :loc_id,   :null => false

      t.timestamps

      t.index [:ip_start, :ip_end]
    end
  end
end
