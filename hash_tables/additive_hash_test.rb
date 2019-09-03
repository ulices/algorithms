require './additive_hash'

describe AdditiveHash do
  before do
    @additive_hash = AdditiveHash.new
  end

  describe 'encode "foo"' do
    it 'must return 324' do
      @additive_hash.encode('foo').must_equal(324)
    end
  end

  describe 'encode "oof"' do
    it 'must return 324' do
      @additive_hash.encode('foo').must_equal(324)
    end
  end

  describe 'encode "this is a long string"' do
    it 'must return 324' do
      @additive_hash.encode('this is a long string').must_equal(1980)
    end
  end
end