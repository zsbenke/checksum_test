require 'test_helper'

class ChecksumTest < ActiveSupport::TestCase
  setup do
    @fixture1 = 'foo bar baz wibble fizzbuzz fizz buzz'
    @fixture2 = 'The quick brown fox jumps over the lazy dog'
    @fixture3 = 'th3seéé wö$rds sh0Uld _Be Cle4ned'
    @fixture4 = 'Árvíztűrő tükörfúrógép'
    @checksum1 = Checksum.new @fixture1
    @checksum2 = Checksum.new @fixture2
    @checksum3 = Checksum.new @fixture3
    @checksum4 = Checksum.new @fixture4
  end

  test 'should return original string' do
    assert_equal @fixture1, @checksum1.original
    assert_equal @fixture2, @checksum2.original
    assert_equal @fixture3, @checksum3.original
    assert_equal @fixture4, @checksum4.original
  end

  test "should generate 10 character long words from original" do
    assert_equal 'Foobarbazw IbblEfizzb UzzfIzzbUz Z', @checksum1.processed_words
    assert_equal 'Thequickbr OwnfOxjUmp Soverthela Zydog', @checksum2.processed_words
    assert_equal 'Thsewrdssh UldbEclEne D', @checksum3.processed_words
    assert_equal 'Rvztrtkrfr Gp', @checksum4.processed_words
  end

  test 'should return the count of original words' do
    assert_equal 7, @checksum1.original_word_count
    assert_equal 9, @checksum2.original_word_count
    assert_equal 5, @checksum3.original_word_count
    assert_equal 2, @checksum4.original_word_count
  end
end
