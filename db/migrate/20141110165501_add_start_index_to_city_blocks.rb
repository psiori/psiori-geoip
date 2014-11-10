class AddStartIndexToCityBlocks < ActiveRecord::Migration
  def change
    add_index :city_blocks, [:ip_start], { unique: true } 
  end
end
