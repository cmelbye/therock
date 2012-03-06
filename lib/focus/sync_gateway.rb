require 'sinatra/base'
require 'socket'

module Focus #:nodoc:
  
  # This is a Sinatra app that connects to the MobWrite daemon via
  # a socket, sends a provided MobWrite command to the daemon, and
  # then returns the result.
  #
  # Essentially, it's a proxy to the MobWrite daemon so that the
  # MobWrite Javascript client can access it.
  
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