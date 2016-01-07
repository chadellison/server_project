require 'socket'

class Server
  attr_accessor :client, :request_lines

  def initialize(client = nil)
    @request_lines = []
    @client = client
    @tcp_server
    @requests = 0
  end

  def respond
    generating_tcp_server
    accept_client
    store_request

    if path == "Path: /"

      client.puts headers
      client.puts output
      client.close

    elsif path == "Path: /hello"
      loop do

        client.puts hello_header
        client.puts hello_output
        @requests += 1
        accept_client

        store_request
      end

    elsif
    end
  end

  def generating_tcp_server(port = 9292)
    @tcp_server = TCPServer.new(port)
  end

  def hello_response
    "<pre>" + "Hello, World! (#{@requests})" + "</pre>"
  end

  def hello_output
    "<html><head></head><body>#{hello_response}</body></html>"
  end

  def hello_header
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{hello_output.length}\r\n\r\n"].join("\r\n")
  end


  def accept_client
    @client = @tcp_server.accept
  end

  def store_request
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def verb
    "Verb: #{@request_lines.first.split.first}\n"
  end

  def path
    "Path: #{@request_lines.first.split[1]}"
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
