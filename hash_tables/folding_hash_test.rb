require 'minitest/autorun'
require './folding_hash'

describe FoldingHash do
  before do
    @folding_hash = FoldingHash.new
  end

  describe 'encode "foo"' do
    it 'must return "7303014"' do
      @folding_hash.encode('foo').must_equal(7303014)
    end
  end

  describe 'encode "oof"' do
    let(:result) { 6713199 }

    it "must return '6713199'" do
      @folding_hash.encode('foo').must_equal(result)
    end
  end

  describe 'encode "lorem ipsum dolor"' do
    it 'must return "1706390818"' do
      @folding_hash.encode('lorem ipsum dolor').must_equal(6001358114)
    end
  end

  describe 'encode "this is a long string"' do
    it 'must return 324' do
      @folding_hash.encode('this is a long string').must_equal(8133987390)
    end
  end
end