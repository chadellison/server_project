require_relative 'response_two'
require_relative 'parse_two'
require 'socket'

class Server
  attr_accessor :client, :hello_count

  def initialize(client = nil)
    @request_lines = []
    @client = client
    @tcp_server
    @requests = 0
    @response
    @hello_count = 0
  end

  def respond
    shutdown = false
    request = Request.new

    request.generating_tcp_server
    until shutdown == true
      request.accept_client
      request_lines = request.store_request
      @client = request.client
      response = Response.new(client, request_lines)#(initializes with client)
      #create the response object and pass in client
      parse = Parse.new(request_lines)
      @requests += 1

      if parse.path == "Path: /"   #one big find path method which calls a couple of response methods
        @response = response.response #
        client.puts headers
        client.puts output

      elsif parse.path == "Path: /hello"

        @response = response.hello_response
          client.puts headers
          client.puts output

      elsif parse.path == "Path: /datetime"
        @response = response.date_response

        client.puts headers
        client.puts output

      elsif parse.path == "Path: /shutdown"
        @response = response.shutdown_response
        shutdown = true
        client.puts headers
        client.puts output
      end
      puts ["Wrote this response:", headers, output].join("\n")
      client.close
      puts "\nResponse complete, exiting."

    end
  end
  def output
    "<html><head></head><body>#{@response}</body></html>" #move to response
  end

  def headers #move to response
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

  #request class
  # def generating_tcp_server(port = 9292)
  #   @tcp_server = TCPServer.new(port)
  # end
  #
  # def accept_client
  #   @client = @tcp_server.accept
  # end
  #
  # def store_request
  #   while line = @client.gets and !line.chomp.empty?
  #     @request_lines << line.chomp
  #   end
  # end
  # #parse class
  #instantiate request class
  # def verb
  #   "Verb: #{@request_lines.first.split.first}\n"
  # end
  #
  # def path
  #   "Path: #{@request_lines.first.split[1]}"
  # end
  #
  # def protocol
  #   "Protocol: #{@request_lines.first.split.last}\n"
  # end
  #
  # def host
  #   "Host: #{@request_lines[1].split(":")[1].strip}\n"
  # end
  #
  # def port
  #   "Port: #{@request_lines[1].split(":").last}\n"
  # end
  #
  # def origin
  #   "Origin: #{@request_lines[1].split(":")[1].strip}\n"
  # end
  #
  # def accept
  #   "Accept: #{@request_lines[2]}\n"
  # end
  # #response class
  #instantiate parse class
  # def response
  #   @response = "<pre>" + verb + path + protocol + host + port + origin + accept + "</pre>"
  # end
  #
  # def hello_response
  #   @response = "<pre>" + "Hello, World! (#{hello_count})" + "</pre>"
  #   @hello_count += 1
  # end
  #
  # def date_response
  #   date = Time.now
  #   date = date.strftime("%I:%M%p on %A, %B %d, %Y")
  #   @response = "<pre>" + "#{date}" + "</pre>"
  # end
  #
  # def shutdown_response
  #   @response = "<pre>" + "Total Requests: #{@requests}" + "</pre>"
  #   @shutdown = true
  # end
