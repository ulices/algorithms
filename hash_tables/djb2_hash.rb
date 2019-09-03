class Djb2Hash
  def encode(string)
    hash = 5381
    string.bytes.each do |byte|
      hash = ((hash << 5) + hash) + byte
    end
    hash
  end
end
