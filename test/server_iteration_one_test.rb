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
