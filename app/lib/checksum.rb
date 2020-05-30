class Checksum
  attr_reader :original

  def initialize(original)
    @original = original
  end

  def original_word_count
    original.split.size
  end

  def cleaned
    @cleaned ||= original.scan(/[a-zA-Z ]+/).join
  end

  def processed_words
    @processed_words ||= split_up_original_words.join(' ')
  end

  private

  def split_up_original_words
    original.gsub(/\s+/, '').scan(/.{1,10}/).map(&:titleize)
  end
end
