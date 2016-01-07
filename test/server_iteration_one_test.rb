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
end

# def test_it_stores_the_client_string_in_an_array
#   # assert_equal ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Accept-Encoding: gzip, deflate", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9", "Accept-Language: en-us", "DNT: 1", "Connection: keep-alive"], server.request_lines
# end
