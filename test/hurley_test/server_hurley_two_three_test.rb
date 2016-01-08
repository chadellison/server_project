require 'minitest/autorun'
require_relative '../../lib/server_iteration_two'
require_relative '../../lib/server_iteration_three'
require 'socket'
require 'hurley'

class ServerTest < Minitest::Test
  def set_up
    client = Hurley::Client.new "localhost:9292"
  end

  def test_it_responds_successfully
    response = Hurley.get("http://localhost:9292")
    assert response.success?
  end

  def test_it_is_part_of_the_string_class
    response = Hurley.get("http://localhost:9292")
    assert_equal String, response.body.class
  end

  def test_header
    response = Hurley.get("http://localhost:9292")
    assert_equal Hurley::Header, response.header.class
  end

  def test_it_has_a_200_status_code
    response = Hurley.get("http://localhost:9292")
    assert_equal 200, response.status_code
  end

  def test_the_scheme_is_localhost
    client = Hurley::Client.new "localhost:9292"
    assert_equal 'localhost', client.scheme
  end
end
