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
end
