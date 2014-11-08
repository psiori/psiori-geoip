require 'CSV'

class CityLocation < ActiveRecord::Base
  
  has_many :city_blocks, :foreign_key => :loc_id, :inverse_of => :city_location
  
  def self.find_by_ip(ip)
    cb = CityBlock.by_ip(ip).first
    return CityLocation.new  if cb.nil?
    cb.city_location || CityLocation.new
  end
  
  def self.import_from_csv(filename, batch_size=5000)
    batch = []
    
    CSV.foreach(filename, :headers => true) do |row|
      
      hash   = row.to_hash
      loc_id = hash.delete 'loc_id'
      
      location = CityLocation.new(hash)
      location.id = loc_id  
      batch << location
      
      if batch.size >= batch_size
        CityLocation.import batch
        batch = []
      end
    end
    CityLocation.import batch  # import reminder
  end
  
end
