require 'socket'

class Server
  attr_accessor :client

  def initialize
    @client = client
    @request_lines = []
  end

  def respond
    tcp_server = TCPServer.new(9292)
    counter = 0
    loop do
    client = tcp_server.accept
      while line = client.gets and !line.chomp.empty?
        @request_lines << line.chomp
      end
      response = "<pre>" + "Hello, World! (#{counter})\n" + "</pre>"
      output = "<html><head></head><body>#{response}</body></html>"
      headers = ["http/1.1 200 ok",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
      counter +=1
    end
  end
end

if __FILE__ == $0
  server = Server.new
  server.respond
end
