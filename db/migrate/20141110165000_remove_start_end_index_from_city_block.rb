class RemoveStartEndIndexFromCityBlock < ActiveRecord::Migration
  def change
    remove_index :city_blocks, name: 'index_city_blocks_on_ip_start_and_ip_end'
  end
end
