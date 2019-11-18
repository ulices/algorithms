require './folding_hash'

class HashTable
  attr_accessor :key, :value, :count, :max_items, :fil_factor

  def initialize(key, value)
    fil_factor = 0.75
    @_array = []
    hash_table = HashTableArray.new(@_array)
  end
end

class HashTableArray
  def initialize _array
    @_array = _array 
    @foldingHash = FoldingHash.new
  end

  def add(key, value)
  end

  def get_hash_code key
    @foldingHash.encode(key)
  end
end