# frozen_string_literal: true

RSpec.describe RuboCop::Haml::RubyExtractor do
  describe '.call' do
    subject do
      described_class.call(processed_source)
    end

    let(:processed_source) do
      RuboCop::ProcessedSource.new(
        source,
        3.1,
        file_path
      )
    end

    let(:file_path) do
      'dummy.haml'
    end

    let(:source) do
      <<~HAML
        a
        = b
        - array.each do |element|
          = element
      HAML
    end

    context 'with valid condition' do
      it 'returns Ruby codes with offset' do
        result = subject
        expect(result.length).to eq(3)
        expect(result[0][:processed_source].raw_source).to eq('b')
        expect(result[0][:offset]).to eq(4)
        expect(result[0][:processed_source].file_path).to eq(file_path)
        expect(result[1][:processed_source].raw_source).to eq('array.each')
        expect(result[1][:offset]).to eq(8)
        expect(result[2][:processed_source].raw_source).to eq('element')
        expect(result[2][:offset]).to eq(36)
      end
    end

    context 'with `else`' do
      let(:source) do
        <<~HAML
          - else
        HAML
      end

      it 'returns Ruby codes with offset' do
        result = subject
        expect(result.length).to eq(1)
        expect(result[0][:processed_source].raw_source).to eq('')
        expect(result[0][:offset]).to eq(6)
      end
    end
  end
end
