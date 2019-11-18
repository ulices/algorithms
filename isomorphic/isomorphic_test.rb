require 'minitest/autorun'
require './isomorphic'

describe Isomorphic do
  let(:word2) { 'YYY' }
  let(:word1) { 'XXX' }

  before do
    @isomorphic = Isomorphic.new(word1, word2)
  end

  it 'has similar size' do
    assert(@isomorphic.similar_size?)
  end

  describe 'case 1' do
    it 'is isomorphic' do
      assert(@isomorphic.isomorphic?)
    end
  end

  describe 'case 2' do
    let(:word2) { 'CBAABC' }
    let(:word1) { 'DEFFED' }

    it 'is isomorphic' do
      assert(@isomorphic.isomorphic?)
    end
  end

  describe 'case 2' do
    let(:word2) { 'RAMBUNCTIOUSLY' }
    let(:word1) { 'THERMODYNAMICS' }

    it 'is isomorphic' do
      assert(@isomorphic.isomorphic?)
    end
  end

  describe 'case 1 false' do
    let(:word2) { 'AB' }
    let(:word1) { 'CC' }

    it 'is isomorphic' do
      refute(@isomorphic.isomorphic?)
    end
  end

  describe 'case 1 false' do
    let(:word2) { 'XXY' }
    let(:word1) { 'XYY' }

    it 'is isomorphic' do
      refute(@isomorphic.isomorphic?)
    end
  end

  describe 'case 1 false' do
    let(:word2) { 'ABAB' }
    let(:word1) { 'CD' }

    it 'is isomorphic' do
      refute(@isomorphic.isomorphic?)
    end
  end

end
