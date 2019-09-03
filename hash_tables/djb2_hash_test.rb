require 'minitest/autorun'
require './djb2_hash'

describe Djb2Hash do
  before do
    @djb2_hash = Djb2Hash.new
  end

  describe 'encode "foo"' do
    let(:result) { 193491849 }

    it 'must return encrypted value' do
      @djb2_hash.encode('foo').must_equal(result)
    end
  end

  describe 'encode "oof"' do
    let(:result) { 193501641 }

    it 'must return encrypted value' do
      @djb2_hash.encode('oof').must_equal(193501641)
    end
  end

  describe 'encode "this is a long string"' do
    let(:result) { 416818788515761524198411502077982657 }

    it "must return encrypted value" do
      @djb2_hash.encode('this is a long string').must_equal(result)
    end
  end
end