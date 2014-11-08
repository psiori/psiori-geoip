class StaticController < ApplicationController
  def index
    @host = "#{request.protocol}#{request.host_with_port}"
    @remote_ip = request.remote_ip
  end
end
