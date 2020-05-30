class Checksum
  attr_reader :original

  def initialize(original)
    @original = original
  end

  def original_word_count
    original.split.size
  end

  def processed_words
    @processed_words ||= process_original_words.join(' ')
  end

  private

  def process_original_words
    @processed_words = original

    # Run original words through processing rules
    remove_non_english_characters
    group_new_words
    titleize_words
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
end
