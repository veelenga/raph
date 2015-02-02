require 'spec_helper'

module Raph
  module Parser
    describe BaseParser do
      describe '#id' do
        it 'is not nil' do
          expect(BaseParser.id).not_to be nil
        end

        it 'is always the same' do
          expect(BaseParser.id).to eq(BaseParser.id)
        end
      end

      describe '#parse' do
        it 'is always nil' do
          expect(subject.parse).to be nil
        end
      end
    end

  end
end
