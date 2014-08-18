require 'spec_helper'

describe Signature do
  it 'deactive by default' do
    expect(Signature.new.active).to be_false
  end

  context 'blank' do
    let(:signature) { build :signature, data: "" }

    it '#blank? returns true' do
      expect(signature.blank?).to be_true
    end

    it '#present? returns false' do
      expect(signature.present?).to be_false
    end

  context 'with blank string too' do
    let(:signature) { build :signature, data: nil }

      it '#blank? returns true' do
        expect(signature.blank?).to be_true
      end

      it '#present? returns false' do
        expect(signature.present?).to be_false
      end
    end
  end

  context 'present' do
    let(:signature) { build :signature, data: "text" }

    it '#blank? returns false' do
      expect(signature.blank?).to be_false
    end

    it '#present? returns true' do
      expect(signature.present?).to be_true
    end
  end

  describe '#updated_at' do
    let(:signature) { create :signature, data: ''}

    it 'nil when signature is blank' do
      expect(signature.updated_at).to be_nil
    end
  end

  describe '#created_at in miliseconds' do
    it 'nil when signature is blank' do
      signature = create :signature, data: nil
      expect(signature.updated_at_in_miliseconds).to be_nil
    end

    it 'return unix timestamp in miliseconds' do
      signature = create :signature
      expect(signature.updated_at_in_miliseconds).to_not be_nil
    end
  end
end
