require 'socket'
require_relative 'response_one'

class Server
  attr_accessor :client, :request_lines

  def initialize(client = nil)
    @request_lines = []
    @client = client
  end

  def respond
    accept_client
    store_request
    client = @client
    send_response = Response.new(request_lines, client)
    send_response.respond(client)
    client.close
  end

  def accept_client(port = 9292)

    tcp_server = TCPServer.new(port)
    @client = tcp_server.accept

  end

  def store_request
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end
end

if __FILE__ == $0
  server = Server.new
  server.respond
end
