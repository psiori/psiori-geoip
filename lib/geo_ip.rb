require 'ipaddr'

module GeoIp
  
  def self.ip2int(ipv4)
    ip = IPAddr.new ipv4
    ip.to_i
  end
  
end