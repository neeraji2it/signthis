require 'spec_helper'

describe DocumentDecorator do
  let(:document) { build_stubbed :document }

  subject { DocumentDecorator.new document }

  describe '#name' do
    let(:document) { build_stubbed :document, first_spouse_last_name: 'Johnson', second_spouse_last_name: 'Richards', created_at: DateTime.new(2013, 10, 31, 16) }

    it 'compose from spouses last names and date' do
      expect(subject.name).to eq '<span>Johnson-Richards-10-31-2013</span>'
    end

    it 'compose from one name if other is not exist' do
      document.stub first_spouse_last_name: nil
      expect(subject.name).to eq '<span>Richards-10-31-2013</span>'
    end

    it 'add bold class for usinged documents' do
      document.should_receive(:signed?).and_return false
      expect(subject.name).to eq "<span class=\"bold\">Johnson-Richards-10-31-2013</span>"
    end
  end

  context 'spouses names' do
    let(:document) { build_stubbed :document, first_spouse_first_name: 'Arnold', first_spouse_last_name: 'Richards', second_spouse_first_name: 'Mike', second_spouse_last_name: 'Johns' }

    it 'combine first and last name' do
      expect(subject.first_spouse_full_name).to eq 'Arnold Richards'
      expect(subject.second_spouse_full_name).to eq 'Mike Johns'
    end

    it 'use only first or last name' do
      document.first_spouse_last_name = nil
      document.second_spouse_first_name = nil
      expect(subject.first_spouse_full_name).to eq 'Arnold'
      expect(subject.second_spouse_full_name).to eq 'Johns'
    end
  end

  context '#link' do
    before { subject.stub name: 'test' }

    it 'use name with full url path' do
      expect(subject.link).to match /<a href=\"http:/
      expect(subject.link).to match /documents\/#{document.id}\">test<\/a>/
    end
  end

  context 'price fields' do
    let(:document) { build_stubbed :document, price: '12', billable_hour: '123'}

    it 'add $ to price' do
      expect(subject.price).to eq '$12'
    end

    it 'add $ to billable_hour' do
      expect(subject.billable_hour).to eq '$123'
    end
  end
end
