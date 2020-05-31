class Checksum
  include ActiveModel::Model

  attr_reader :original

  VOWELS = %w[a e i o u].freeze
  CONSONANTS = (('a'..'z').to_a - VOWELS).freeze

  delegate :length, to: :original, prefix: :original

  def initialize(original = '')
    @original = original
  end

  def words
    @words ||= process_original_words.join(' ')
  end

  def original_words_count
    original.split.size
  end

  def words_count
    words.split.count
  end

  def uppercase_vowels_count
    words.split(//).select { |c| uppercase_vowel?(c) }.count
  end

  def consonants_count
    words.split(//).select { |c| consonant?(c) }.count
  end

  def to_s
    [
      original_words_count,
      words_count,
      uppercase_vowels_count,
      consonants_count,
      original_length
    ].join('-')
  end

  private

  def process_original_words
    @words = original

    # Run original words through processing rules
    remove_non_english_chars
    group_new_words
    titleize_words
    upcase_vowels
  end

  def remove_non_english_chars
    @words = @words.scan(/[a-zA-Z ]+/).join
  end

  def group_new_words
    @words = @words.gsub(/\s+/, '').scan(/.{1,10}/)
  end

  def titleize_words
    @words = @words.map(&:downcase).map(&:titleize)
  end

  def upcase_vowels
    @words = @words.join.split(//)
    @words.each_with_index do |char, i|
      # No need to process if the current character is a consonant or the first one.
      next if consonant?(char) || i == 0

      # Upcase the current character – which should be a vowel – if the previous two are
      # consonants and the previous vowel is uppercase.
      previous_vowel = find_previous_vowel(chars: @words, char_index: i)
      previous_chars = find_previous_chars(chars: @words, char_index: i, range: 2)
      if consonants?(previous_chars) && uppercase_vowel?(previous_vowel)
        @words[i] = char.upcase
      end
    end

    @words = @words.join.scan(/.{1,10}/)
  end

  def find_previous_vowel(chars:, char_index:)
    chars.slice(0, char_index).select { |char| vowel?(char) }.last
  end

  def find_previous_chars(chars:, char_index:, range:)
    chars.slice(char_index - range, range)
  end

  def consonant?(char)
    CONSONANTS.include?(char.downcase)
  end

  def consonants?(chars)
    chars.all? { |char| consonant?(char) }
  end

  def vowel?(char)
    VOWELS.include?(char.downcase)
  end

  def uppercase_vowel?(char)
    VOWELS.map(&:upcase).include?(char)
  end
end
