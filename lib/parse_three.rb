require_relative 'request_three'

class Parse
  def initialize(request_lines)
    @request_lines = request_lines
  end

  def verb
    "Verb: #{@request_lines.first.split.first}\n"
  end

  def path
    "Path: #{@request_lines.first.split[1].split("?").first}"
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

  def word
    word = @request_lines.first.split("=").last.split.first

    if File.read("/usr/share/dict/words").include?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end 

  def parsed_request
    verb + path + protocol + host + port + origin + accept
  end
end
