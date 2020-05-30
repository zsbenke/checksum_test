require 'test_helper'

class ChecksumTest < ActiveSupport::TestCase
  setup do
    @fixture1 = 'foo bar baz wibble fizzbuzz fizz buzz'
    @fixture2 = 'The quick brown fox jumps over the lazy dog'
    @fixture3 = 'th3seéé wö$rds sh0Uld _Be Cle4ned'
    @fixture4 = 'Árvíztűrő tükörfúrógép'
  end

  test 'should return original string' do
    checksum = Checksum.new @fixture1
    assert_equal @fixture1, checksum.original
  end

  test 'should return count of original words' do
    checksum1 = Checksum.new @fixture1
    assert_equal 7, checksum1.original_word_count

    checksum2 = Checksum.new @fixture2
    assert_equal 9, checksum2.original_word_count
  end

  test 'should clean up original words' do
    checksum1 = Checksum.new @fixture3
    assert_equal 'thse wrds shUld Be Clened', checksum1.cleaned

    checksum2 = Checksum.new @fixture4
    assert_equal 'rvztr tkrfrgp', checksum2.cleaned
  end

  test "should generate 10 character long words from original" do
    checksum1 = Checksum.new @fixture1
    assert_equal 'foobarbazw ibblefizzb uzzfizzbuz z', checksum1.generated_words

    checksum2 = Checksum.new @fixture2
    assert_equal 'Thequickbr ownfoxjump soverthela zydog', checksum2.generated_words
  end
end
