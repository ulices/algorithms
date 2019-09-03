class AdditiveHash
  def encode(string)
    string.bytes.reduce(:+)
  end
end
