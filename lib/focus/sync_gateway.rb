require 'sinatra/base'
require 'socket'

module Focus
  class SyncGateway < Sinatra::Base
    post "/sync" do
      s = TCPSocket.new 'rockonline-N5USRDTV.dotcloud.com', 22653

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