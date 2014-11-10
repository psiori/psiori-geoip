class RemoveUnnecessaryIndicesFromCityBlocks < ActiveRecord::Migration
  def change
    remove_index :city_blocks, name: 'index_city_blocks_on_ip_start_and_ip_end_and_id'
    remove_index :city_blocks, name: 'index_city_blocks_on_ip_start_and_ip_end'
    remove_index :city_blocks, name: 'index_city_blocks_on_ip_end'    
  end
end
