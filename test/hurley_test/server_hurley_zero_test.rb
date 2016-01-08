require 'minitest/autorun'
require_relative '../../lib/server_iteration_zero'
require 'socket'
require 'hurley'

class ServerTest < Minitest::Test
  def set_up
    client = Hurley::Client.new "localhost:9292"
  end

  def test_it_responds_and_the_body_is_a_string
    response = Hurley.get("http://localhost:9292")
    assert response.success?
    assert_equal String, response.body.class
    assert_equal Hurley::Header, response.header.class
    assert_equal 200, response.status_code
    client = Hurley::Client.new "localhost:9292"
    assert_equal 'localhost', client.scheme
  end
end
