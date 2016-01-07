require 'socket'

class Server
  attr_accessor :client, :request_lines

  def initialize(client = nil)
    @request_lines = []
    @client = client
    @tcp_server
    @requests = 0
    @hello_counter = 0
    @response
  end

  def respond
    generating_tcp_server
    accept_client
    store_request
    until path == "Path: /shutdown"

      if path == "Path: /"
        response
        client.puts headers
        client.puts output

      elsif path == "Path: /hello"
          hello_response
          client.puts headers
          client.puts output
          @requests += 1

      elsif path == "Path: /datetime"
        date_response

        client.puts headers
        client.puts output

      end
      puts ["Wrote this response:", headers, output].join("\n")
      client.close

      accept_client
      @request_lines = []
      store_request
    end
    shutdown_response
    client.puts headers
    client.puts output
    client.close
    puts "\nResponse complete, exiting."
  end

  def generating_tcp_server(port = 9292)
    @tcp_server = TCPServer.new(port)
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
    @response = "<pre>" + verb + path + protocol + host + port + origin + accept + "</pre>"
  end

  def hello_response
    @response = "<pre>" + "Hello, World! (#{@hello_counter})" + "</pre>"
    @hello_counter += 1
  end

  def date_response
    date = Time.now
    date = date.strftime("%I:%M%p on %A, %B %d, %Y")
    @response = "<pre>" + "#{date}" + "</pre>"
  end

  def shutdown_response
    @response = "<pre>" + "Total Requests: #{@requests}" + "</pre>"
  end

  def output
    "<html><head></head><body>#{@response}</body></html>"
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
