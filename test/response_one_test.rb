require 'minitest/autorun'
require_relative '../lib/response_one'

class ResponseTest < Minitest::Test
  def test_the_verb_method_returns_the_formatted_verb
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Verb: GET\n", response.verb
  end

  def test_the_path_method_returns_the_formatted_path
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Path: /\n", response.path
  end

  def test_the_protocol_method_returns_the_formatted_protocol
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Protocol: HTTP/1.1\n", response.protocol
  end

  def test_the_host_method_returns_the_formatted_host
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Host: 127.0.0.1\n", response.host
  end

  def test_the_port_method_returns_the_formatted_port
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Port: 9292\n", response.port
  end

  def test_the_origin_method_returns_the_formatted_origin
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Origin: 127.0.0.1\n", response.origin
  end

  def test_the_accept_method_returns_the_formatted_accept
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n", response.accept
  end

  def test_the_response_method_returns_the_formatted_response
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    response = Response.new(request)
    assert_equal "<pre>" + "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n" + "</pre>", response.response
  end
end
