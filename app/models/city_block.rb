require 'geo_ip'
require 'CSV'

class CityBlock < ActiveRecord::Base

  scope :by_ip, lambda { |ip| where(['ip_start <= ? AND ip_end >= ?', GeoIp.ip2int(ip), GeoIp.ip2int(ip)]) }
  
  def self.find_by_ip(ip)
    CityBlock.by_ip(ip).first
  end
  
  def self.import_from_csv(filename, batch_size=5000)
    batch = []
    
    CSV.foreach(filename, :headers => true) do |row|
      batch << CityBlock.new(row.to_hash)
      if batch.size >= batch_size
        CityBlock.import batch
        batch = []
      end
    end
    CityBlock.import batch  # import reminder
  end
  
end
