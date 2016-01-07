class Response
  def initialize(request_lines, client = nil)
    @request_lines = request_lines
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

  def respond(client)
    client.puts headers
    client.puts output
  end
end
