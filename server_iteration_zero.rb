require 'socket'

class Server
  attr_accessor :client, :counter

  def initialize
    @counter = 0
  end

  def response
    "<pre>Hello, World! (#{@counter})\n</pre>"
  end

  def output
    "<html><head></head><body>#{response}</body></html>"
  end

  def headers
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def respond
    tcp_server = TCPServer.new(9292)
    
    loop do
      client = tcp_server.accept

      client.puts headers
      client.puts output
      @counter +=1
    end
  end
end

if __FILE__ == $0
  server = Server.new
  server.respond
end
