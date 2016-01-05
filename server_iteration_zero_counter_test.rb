require 'minitest/autorun'
require_relative 'server_iteration_zero'
require 'socket'
require 'hurley'

class CounterTest < Minitest::Test

  def set_up
    client = Hurley::Client.new "localhost:9292"
  end

  def test_response_increments_with_requests
    content = Hurley.get("http://localhost:9292")
    content = Hurley.get("http://localhost:9292")
    content = Hurley.get("http://localhost:9292")
    content = Hurley.get("http://localhost:9292")
    assert_equal "<html><head></head><body><pre>Hello, World! (3)\n</pre></body></html>", content.body
  end
end
