class AddStartEndIdIndexToCityBlocks < ActiveRecord::Migration
  def change
    add_index :city_blocks, [:ip_start, :ip_end, :id], { unique: true } 
  end
end
