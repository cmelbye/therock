require 'sinatra/base'
require 'socket'

module Focus
  class SyncGateway < Sinatra::Base
    post "/sync" do
      if Rails.env.production?
        s = TCPSocket.new 'rockonline-N5USRDTV.dotcloud.com', 22653
      else
        s = TCPSocket.new 'localhost', 3017
      end

      out = ""

      s.write params['q']

      while line = s.gets
        out += line
      end

      s.close

      content_type "text/plain"
      out + "\n"
    end
  end
end