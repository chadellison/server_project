require_relative 'parse_two'

class Response #add headers and output also sent here
  attr_reader :request_lines

  def initialize(client, request_lines)
    @client = client
    @request_lines = request_lines
    @hello_count = 0
  end

  def response #removed response = within the method
    parse = Parse.new(request_lines) #need an arg
    response = "<pre>" + parse.parsed_request + "</pre>"
  end

  def hello_response
    response = "<pre>" + "Hello, World! (#{@hello_count})" + "</pre>"
    @hello_count += 1
    response
  end

  def date_response
    date = Time.now
    date = date.strftime("%I:%M%p on %A, %B %d, %Y")
    response = "<pre>" + "#{date}" + "</pre>"
  end

  def shutdown_response
    response = "<pre>" + "Total Requests: #{@hello_count}" + "</pre>"
  end
end
