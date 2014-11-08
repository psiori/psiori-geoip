require 'geo_ip'

class CityBlock < ActiveRecord::Base

  scope :by_ip, lambda { |ip| where(['ip_start <= ? AND ip_end >= ?', GeoIp.ip2int(ip), GeoIp.ip2int(ip)]) }
  
  def self.find_by_ip(ip)
    CityBlock.by_ip(ip).first
  end
  
end
