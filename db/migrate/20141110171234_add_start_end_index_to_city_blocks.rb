class AddStartEndIndexToCityBlocks < ActiveRecord::Migration
  def change
    add_index :city_blocks, [:ip_start, :ip_end], { unique: true } 
  end
end
