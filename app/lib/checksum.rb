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

  def generated_words
    @generated_words ||= original.gsub(/\s+/, '').scan(/.{1,10}/).join(' ')
  end
end
