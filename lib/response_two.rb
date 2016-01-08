require_relative 'parse_two'

class Response #add headers and output also sent here
  attr_reader :request_lines

  def initialize(client, request_lines)
    @client = client
    @request_lines = request_lines
    @response
  end

  def formatted_response
    @client.puts headers
    @client.puts output
  end

  def root_response #removed response = within the method
    parse = Parse.new(request_lines) #need an arg
    @response = "<pre>" + parse.parsed_request + "</pre>"
    formatted_response
  end

  def hello_response(hello_count)
    @response = "<pre>" + "Hello, World! (#{hello_count})" + "</pre>"
    formatted_response
  end

  def date_response
    date = Time.now
    date = date.strftime("%I:%M%p on %A, %B %d, %Y")
    @response = "<pre>" + "#{date}" + "</pre>"
    formatted_response
  end

  def shutdown_response(request_count)
    @response = "<pre>" + "Total Requests: #{request_count}" + "</pre>"
    puts ["Wrote this response:", headers, output].join("\n")
    formatted_response
    puts "\nResponse complete, exiting."
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
