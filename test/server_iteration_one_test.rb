require 'minitest/autorun'
require_relative '../lib/server_iteration_one'

class ServerTest < Minitest::Test
  def test_it_is_part_of_the_server_class
    server = Server.new
    assert_equal Server, server.class
  end

  def test_server_object_accepts_an_argument
    server = Server.new("Hello\nthis\nis...")
    assert_equal "Hello\nthis\nis...", server.client
  end

  def test_the_verb_method_returns_the_formatted_verb
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Verb: GET\n", server.verb
  end

  def test_the_path_method_returns_the_formatted_path
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Path: /\n", server.path
  end

  def test_the_protocol_method_returns_the_formatted_protocol
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Protocol: HTTP/1.1\n", server.protocol
  end

  def test_the_host_method_returns_the_formatted_host
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Host: 127.0.0.1\n", server.host
  end

  def test_the_port_method_returns_the_formatted_port
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Port: 9292\n", server.port
  end

  def test_the_origin_method_returns_the_formatted_origin
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Origin: 127.0.0.1\n", server.origin
  end

  def test_the_accept_method_returns_the_formatted_accept
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n", server.accept
  end

  def test_the_response_method_returns_the_formatted_response
    server = Server.new
    server.request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    assert_equal "<pre>" + "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n" + "</pre>", server.response 
  end

end

# def test_it_stores_the_client_string_in_an_array
#   # assert_equal ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"], server.request_lines
# end
