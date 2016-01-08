require_relative 'response_three'
require_relative 'parse_three'
require 'socket'

class Server
  attr_accessor :client, :hello_count
  attr_reader :request_counter

  def initialize(client = nil)
    @client = client
    @request_counter = 0
    @response
    @hello_count = 0
    @shutdown = false
  end

  def find_correct_path(parse, response)
    if parse.path == "Path: /"
      response.root_response
    elsif parse.path == "Path: /hello"
      hello_count = @hello_count += 1
      response.hello_response(hello_count)
    elsif parse.path == "Path: /datetime"
      response.date_response
    elsif parse.path == "Path: /word_search"
      response.word_search_response
    elsif parse.path == "Path: /shutdown"
      response.shutdown_response(request_counter)
      @shutdown = true
    end
  end

  def respond
    request = Request.new
    request.generating_tcp_server

    until @shutdown == true
      request.open_server
      request_lines = request.store_request

      @client = request.client
      response = Response.new(client, request_lines)
      parse = Parse.new(request_lines)
      request_counter = @request_counter += 1
      find_correct_path(parse, response)
      client.close
    end
  end
end

if __FILE__ == $0
  server = Server.new
  server.respond
end
