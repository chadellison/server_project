require 'minitest/autorun'
require_relative '../lib/server_iteration_three'
require 'hurley'

class ServerTest < Minitest::Test
  def test_it_is_part_of_the_server_class
    server = Server.new
    assert_equal Server, server.class
  end

  def test_server_object_accepts_an_argument
    server = Server.new("Hello\nthis\nis...")
    assert_equal "Hello\nthis\nis...", server.client
  end

  def test_server_object_does_not_need_an_argument
    assert Server.new
  end

  def test_request_counter_starts_at_zero
    server = Server.new
    assert_equal 0, server.request_counter
  end

  def test_hello_count_starts_at_zero
    server = Server.new
    assert_equal 0, server.hello_count
  end
end
