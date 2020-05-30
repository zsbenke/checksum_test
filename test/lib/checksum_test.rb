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

  test 'should generate string format of checksum' do
    assert_equal '7-4-5-21-37', @checksum1.to_s
    assert_equal '9-4-3-24-43', @checksum2.to_s
    assert_equal '5-3-3-16-33', @checksum3.to_s
    assert_equal '2-2-0-12-22', @checksum4.to_s
  end

  test 'should return original string' do
    assert_equal @fixture1, @checksum1.original
    assert_equal @fixture2, @checksum2.original
    assert_equal @fixture3, @checksum3.original
    assert_equal @fixture4, @checksum4.original
  end

  test 'should generate 10 character long words from original' do
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

  test 'should return the count of processed words' do
    assert_equal 4, @checksum1.processed_words_count
    assert_equal 4, @checksum2.processed_words_count
    assert_equal 3, @checksum3.processed_words_count
    assert_equal 2, @checksum4.processed_words_count
  end

  test 'should return the count of uppercase vowels' do
    assert_equal 5, @checksum1.upcase_vowels_count
    assert_equal 3, @checksum2.upcase_vowels_count
    assert_equal 3, @checksum3.upcase_vowels_count
    assert_equal 0, @checksum4.upcase_vowels_count
  end

  test 'should return the count of consonants' do
    assert_equal 21, @checksum1.consonants_count
    assert_equal 24, @checksum2.consonants_count
    assert_equal 16, @checksum3.consonants_count
    assert_equal 12, @checksum4.consonants_count
  end

  test 'should return the length of the original string' do
    assert_equal 37, @checksum1.original_length
    assert_equal 43, @checksum2.original_length
    assert_equal 33, @checksum3.original_length
    assert_equal 22, @checksum4.original_length
  end
end
