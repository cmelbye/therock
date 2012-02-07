require 'sinatra/base'
require 'socket'

module Focus
  class SyncGateway < Sinatra::Base
    post "/sync" do
      s = TCPSocket.new 'rockonline-N5USRDTV.dotcloud.com', 22653

      out = ""
      puts params['q']
      s.write params['q']
      puts "wrote"
      while !s.eof?
        puts "recving"
        out += s.recv(1024)
        puts out
      end

      s.close

      out
    end
  end
end