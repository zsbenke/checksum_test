class Checksum
  attr_reader :original

  VOWELS = %w(a e i o u).freeze
  CONSONANTS = (('a'..'z').to_a - VOWELS).freeze

  def initialize(original)
    @original = original
  end

  def processed_words
    @processed_words ||= process_original_words.join(' ')
  end

  def original_word_count
    original.split.size
  end

  def processed_words_count
    processed_words.split.count
  end

  def upcase_vowels_count
    processed_words.split(//).select { |c| upcase_vowel?(c) }.count
  end

  def consonants_count
    processed_words.split(//).select { |c| consonant?(c) }.count
  end

  def original_length
    original.length
  end

  def to_s
    [
      original_word_count,
      processed_words_count,
      upcase_vowels_count,
      consonants_count,
      original_length
    ].join('-')
  end

  private

  def process_original_words
    @processed_words = original

    # Run original words through processing rules
    remove_non_english_characters
    group_new_words
    titleize_words
    upcase_vowels
  end

  def remove_non_english_characters
    @processed_words = @processed_words.scan(/[a-zA-Z ]+/).join
  end

  def group_new_words
    @processed_words = @processed_words.gsub(/\s+/, '').scan(/.{1,10}/)
  end

  def titleize_words
    @processed_words = @processed_words.map(&:downcase).map(&:titleize)
  end

  def upcase_vowels
    @processed_words.each_with_index do |word, i|
      @processed_words[i] = upcase_vowels_in_word(word)
    end
  end

  def upcase_vowels_in_word(word)
    # No need to process the word when the first character isn't an uppercase
    # vowel already.
    return word unless upcase_vowel?(word.chr)

    word = word.split(//)
    word.each_with_index do |char, i|
      # No need to process if the current character is a consonant or the first one.
      next if consonant?(char) || i == 0

      # Upcase the current character – which should be a vowel – if the previous two are
      # consonants and the previous vowel is upcase.
      previous_vowel = find_previous_vowel(word, i)
      if consonant?(word[i-1]) && consonant?(word[i-2]) && upcase_vowel?(previous_vowel)
        word[i] = char.upcase
      end
    end

    word.join
  end

  def find_previous_vowel(word_array, i)
    word_array.slice(0, i).select { |char| vowel?(char) }.last
  end

  def consonant?(char)
    CONSONANTS.include?(char.downcase)
  end

  def vowel?(char)
    VOWELS.include?(char.downcase)
  end

  def upcase_vowel?(char)
    VOWELS.map(&:upcase).include?(char)
  end
end
