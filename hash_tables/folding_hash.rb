class FoldingHash
  def encode(string)
    bytes, encoded_bytes = string.bytes, 0

    encoded_bytes += encode_bytes(bytes.shift(4)) while bytes.size > 0

    encoded_bytes
  end

  private

  def encode_bytes(bytes, inc_shift: 0)
    bytes.collect do |byte|
      shifted_byte = byte << inc_shift
      inc_shift += 8
      shifted_byte
    end.reduce(:+)
  end
end
