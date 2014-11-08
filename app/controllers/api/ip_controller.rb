require 'geo_ip'

class Api::IpController < ApplicationController
  
  def show
    @ipv4 = params[:id].to_s

    begin
      @city_location = CityLocation.find_by_ip(@ipv4)
    rescue
    end
    
    respond_to do |format|
      if !@city_location.nil?
        format.json
      else
        format.json { render :json => { error: "Could not process ip #{ @ipv4 }" }, :status => :unprocessable_entity }
      end
    end
  end
  
end
