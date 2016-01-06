require 'socket'

class Server
  attr_accessor :client, :request_lines

  def initialize(client = nil)
    @request_lines = []
    @client = client
  end

  def respond
    accept_client
    store_request

    client.puts headers
    client.puts output

    client.close
  end

  def accept_client(port = 9292)

    tcp_server = TCPServer.new(port)
    @client = tcp_server.accept

  end

  # def store_request_helper(help_arg)
  #   @request_lines = help_arg
  # end

  def store_request
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def verb
    "Verb: #{@request_lines.first.split.first}\n"
  end

  def path
    "Path: #{@request_lines.first.split[1]}\n"
  end

  def protocol
    "Protocol: #{@request_lines.first.split.last}\n"
  end

  def host
    "Host: #{@request_lines[1].split(":")[1].strip}\n"
  end

  def port
    "Port: #{@request_lines[1].split(":").last}\n"
  end

  def origin
    "Origin: #{@request_lines[1].split(":")[1].strip}\n"
  end

  def accept
    "Accept: #{@request_lines[2]}\n"
  end

  def response
    "<pre>" + verb + path + protocol + host + port + origin + accept + "</pre>"
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
end

if __FILE__ == $0
  server = Server.new
  server.respond
end

#original iteration zero
# require 'socket'
#
# class Server
#   attr_accessor :client, :counter
#
#   def initialize
#     @client = client
#     @request_lines = []
#     @counter = counter
#   end
#
#   def get(client)
#     while line = client.gets and !line.chomp.empty?
#       @request_lines << line.chomp
#     end
#   end
#
#   def response
#     response = "<pre>" + "Hello, World! (#{@counter})\n" + "</pre>"
#   end
#
#   def output
#     output = "<html><head></head><body>#{response}</body></html>"
#   end
#
#   def headers
#     headers = ["http/1.1 200 ok",
#               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
#               "server: ruby",
#               "content-type: text/html; charset=iso-8859-1",
#               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
#   end
#
#   def respond
#     tcp_server = TCPServer.new(9292)
#     @counter = 0
#     loop do
#       client = tcp_server.accept
#
#       get(client)
#
#       client.puts headers
#       client.puts output
#       @counter +=1
#     end
#   end
# end
#
# if __FILE__ == $0
#   server = Server.new
#   server.respond
# end
