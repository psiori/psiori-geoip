ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

silence_warnings { ENV["RAILS_ENV"] = "production" }
ActiveRecord::Base.establish_connection

require 'rails/test_help'
require 'rails/performance_test_help'