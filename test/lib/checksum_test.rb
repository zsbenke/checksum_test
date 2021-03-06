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

  test 'should generate output of checksum' do
    assert_equal '7-4-5-21-37', @checksum1.output
    assert_equal '9-4-4-24-43', @checksum2.output
    assert_equal '5-3-3-16-33', @checksum3.output
    assert_equal '2-2-0-12-22', @checksum4.output
  end

  test 'should return input string' do
    assert_equal @fixture1, @checksum1.input
    assert_equal @fixture2, @checksum2.input
    assert_equal @fixture3, @checksum3.input
    assert_equal @fixture4, @checksum4.input
  end

  test 'should generate 10 character long words from input' do
    assert_equal 'Foobarbazw IbblEfizzb UzzfIzzbUz Z', @checksum1.words
    assert_equal 'Thequickbr OwnfOxjUmp SOverthela Zydog', @checksum2.words
    assert_equal 'Thsewrdssh UldbEclEne D', @checksum3.words
    assert_equal 'Rvztrtkrfr Gp', @checksum4.words
  end

  test 'should return the count of input words' do
    assert_equal 7, @checksum1.input_words_count
    assert_equal 9, @checksum2.input_words_count
    assert_equal 5, @checksum3.input_words_count
    assert_equal 2, @checksum4.input_words_count
  end

  test 'should return the count of processed words' do
    assert_equal 4, @checksum1.words_count
    assert_equal 4, @checksum2.words_count
    assert_equal 3, @checksum3.words_count
    assert_equal 2, @checksum4.words_count
  end

  test 'should return the count of uppercase vowels' do
    assert_equal 5, @checksum1.uppercase_vowels_count
    assert_equal 4, @checksum2.uppercase_vowels_count
    assert_equal 3, @checksum3.uppercase_vowels_count
    assert_equal 0, @checksum4.uppercase_vowels_count
  end

  test 'should return the count of consonants' do
    assert_equal 21, @checksum1.consonants_count
    assert_equal 24, @checksum2.consonants_count
    assert_equal 16, @checksum3.consonants_count
    assert_equal 12, @checksum4.consonants_count
  end

  test 'should return the length of the input string' do
    assert_equal 37, @checksum1.input_length
    assert_equal 43, @checksum2.input_length
    assert_equal 33, @checksum3.input_length
    assert_equal 22, @checksum4.input_length
  end
end
