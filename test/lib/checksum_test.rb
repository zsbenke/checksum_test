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

  test "should generate 10 character long words from original" do
    checksum1 = Checksum.new @fixture1
    assert_equal 'Foobarbazw Ibblefizzb Uzzfizzbuz Z', checksum1.processed_words

    checksum2 = Checksum.new @fixture2
    assert_equal 'Thequickbr Ownfoxjump Soverthela Zydog', checksum2.processed_words

    checksum3 = Checksum.new @fixture3
    assert_equal 'Thsewrdssh Uldbeclene D', checksum3.processed_words

    checksum4 = Checksum.new @fixture4
    assert_equal 'Rvztrtkrfr Gp', checksum4.processed_words
  end
end
