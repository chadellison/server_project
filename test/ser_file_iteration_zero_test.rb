require 'minitest/autorun'
require_relative '../lib/server_iteration_zero'

class ServerTest < Minitest::Test
  def test_it_is_part_of_the_server_class
    server = Server.new
    assert_equal Server, server.class
  end

  def test_return_value_of_response_method
    server = Server.new
    assert_equal "<pre>Hello, World! (0)\n</pre>", server.response
  end

  def test_return_value_of_output_method_in_html
    server = Server.new
    assert_equal "<html><head></head><body><pre>Hello, World! (0)\n</pre></body></html>",
    server.output
  end

  def test_return_value_of_headers_method_is_a_formatted_string
    server = Server.new
    assert_equal String, server.headers.class
  end
end
