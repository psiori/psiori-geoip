#!/usr/bin/env ruby
#
# Helper that extracts geo locations for all players.
#

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

puts "--> Downloading and compiling data using the freegeoip script..."
#system("./updatedb")

puts "--> Exporting CSV files..."
#system("sqlite3 ipdb.sqlite < exportdb.sqlite3")

puts "--> Importing to rails database..."
CityBlock.delete_all

CityBlock.import_from_csv('city_blocks_out.csv')