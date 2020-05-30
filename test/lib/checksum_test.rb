require 'test_helper'

class ChecksumTest < ActiveSupport::TestCase
  setup do
    @fixture1 = 'foo bar baz wibble fizzbuzz fizz buzz'
    @fixture2 = 'The quick brown fox jumps over the lazy dog'
  end

  test 'should return original string' do
    checksum = Checksum.new @fixture1
    assert_equal @fixture1, checksum.original
  end
end
