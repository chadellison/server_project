require 'socket'

class Request
  attr_accessor :client

  def generating_tcp_server(port = 9292) #consider moving to server class --> not part of reaquest
    @tcp_server = TCPServer.new(port)
  end

  def open_server
    @client = @tcp_server.accept
  end

  def store_request
    request_lines = []
    while line = @client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end
end
