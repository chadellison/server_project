require 'minitest/autorun'
require_relative '../lib/parse_three'

class ParseTest < Minitest::Test
  def test_the_verb_method_returns_the_formatted_verb
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Verb: GET\n", parse.verb
  end

  def test_the_path_method_returns_the_formatted_path
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Path: /", parse.path
  end

  def test_the_protocol_method_returns_the_formatted_protocol
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Protocol: HTTP/1.1\n", parse.protocol
  end

  def test_the_host_method_returns_the_formatted_host
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Host: 127.0.0.1\n", parse.host
  end

  def test_the_port_method_returns_the_formatted_port
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Port: 9292\n", parse.port
  end

  def test_the_origin_method_returns_the_formatted_origin
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Origin: 127.0.0.1\n", parse.origin
  end

  def test_the_accept_method_returns_the_formatted_accept
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n", parse.accept
  end

  def test_the_word_method_returns_a_known_word
    request = ["GET /word_search?word=computer HTTP/1.1", "Host: 127.0.0.1:9292"]
    parse = Parse.new(request)
    assert_equal "computer is a known word", parse.word
  end

  def test_the_word_method_rejects_a_fake_word
    request = ["GET /word_search?word=fromputer HTTP/1.1", "Host: 127.0.0.1:9292"]
    parse = Parse.new(request)
    assert_equal "fromputer is not a known word", parse.word
  end

  def test_the_parsed_request_method_returns_the_formatted_response
    request = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"]
    parse = Parse.new(request)
    assert_equal "Verb: GET\nPath: /Protocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\n", parse.parsed_request
  end

  def test_the_word_method_returns_a_more_complex_known_word
    request = ["GET /word_search?word=esoteric HTTP/1.1", "Host: 127.0.0.1:9292"]
    parse = Parse.new(request)
    assert_equal "esoteric is a known word", parse.word
  end

  def test_the_word_method_rejects_a_more_complex_fake_word
    request = ["GET /word_search?word=accessorinessness HTTP/1.1", "Host: 127.0.0.1:9292"]
    parse = Parse.new(request)
    assert_equal "accessorinessness is not a known word", parse.word
  end

end
