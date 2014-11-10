require 'performance_test_helper'

class ApiGeoipTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "homepage" do
    get '/api/v01/ip/87.128.57.12'
  end
end
