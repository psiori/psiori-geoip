class AddEndIndexToCityBlocks < ActiveRecord::Migration
  def change
    add_index :city_blocks, [:ip_end], { unique: true } 
  end
end
