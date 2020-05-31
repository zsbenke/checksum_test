require 'test_helper'

class ChecksumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixture = 'foo bar baz wibble fizzbuzz fizz buzz'
    @checksum_params = { original: @fixture }
    @checksum = Checksum.new @fixture
  end

  test 'should get new' do
    get new_checksum_url
    assert_response :success
    assert_equal 'text/html', @response.media_type
  end

  test 'should post create' do
    post checksum_url(format: :json), params: { checksum: @checksum_params }
    assert_response :success
    assert_equal 'application/json', @response.media_type
    assert_match @checksum.to_s, @response.body
  end
end
