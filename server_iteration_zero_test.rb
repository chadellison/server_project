require 'minitest/autorun'
require_relative 'server_iteration_zero'
require 'socket'
require 'hurley'

class ServerTest < Minitest::Test

  def set_up
    client = Hurley::Client.new "localhost:9292"
  end

  def test_it_is_a_server_object
    server = Server.new
    assert_equal Server, server.class
  end

  def test_it_responds
    response = Hurley.get("http://localhost:9292")
    assert response.success?
  end

  def test_the_body_is_a_string
    response = Hurley.get("http://localhost:9292")
    assert_equal String, response.body.class
  end
end
