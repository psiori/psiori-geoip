class CreateCityLocations < ActiveRecord::Migration
  def change
    create_table :city_locations do |t|
      t.string :country_code
      t.string :region_code
      t.string :city_name
      t.string :postal_code
      t.decimal :latitude, :default => 0, :null => false
      t.decimal :longitude, :default => 0, :null => false
      t.string :metro_code
      t.string :area_code
      
      t.timestamps
    end
  end
end
