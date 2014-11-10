require 'geo_ip'
require 'csv'

class CityBlock < ActiveRecord::Base
  
  belongs_to :city_location, :foreign_key => :loc_id, :inverse_of => :city_blocks

  # REGARDING SCOPE PERFORMANCE:
  #
  # by_ip would be the correct query to use IF mutli-column indices
  # in postgres would allow several inequalities in one range query.
  # Unfortunately, the first column would have to be an equality
  # and only the second column could be an inequality if the
  # multi-column index should be used.
  # Thus, we came up with a solution that simply ignores the ip_end,
  # uses a one-column index on ip_start and simply scans the index
  # for the first row that has an ip_start smaller than our query
  # while stepping BACKWARDS through ip_start (scanning from largest
  # to smallest ip_start).
  #
  # Since the answer of by_ip_fast might be wrong IFF there are
  # holes in the data (ip_start is smaller than query, but the block
  # also endds before the query with ip_end ALSO smaller than query),
  # we have a fallback query in find_by_ip that makes sure we'll 
  # always return the corret answer.
  scope :by_ip_fast, lambda { |ip| where(['ip_start <= ?', GeoIp.ip2int(ip)]).order(ip_start: :desc) }
  scope :by_ip,      lambda { |ip| where(['ip_start <= ? AND ip_end >= ?', GeoIp.ip2int(ip), GeoIp.ip2int(ip)]) }
  
  def self.find_by_ip(ip)
    ipint = GeoIp.ip2int(ip)
    cb = CityBlock.by_ip_fast(ip).first
    if !cb.nil? && cb.ip_start <= GeoIp.ip2int(ipint) && cb.ip_end >= GeoIp.ip2int(ipint)
      cb
    else # fallback for the case where the data is inconsistent, e.g. does contain a hole
      logger.error "Fast ip lookup failed for ip: #{ip}."
      CityBlock.by_ip(ip).first
    end
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
