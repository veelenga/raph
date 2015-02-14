require 'spec_helper'

require 'raph/parser/file_parser'

module Raph
  module Parser
    describe FileParser do
      describe '#parse' do
        it 'detects files' do
          expect(subject.parse(['**/*.rb'])).to include(Dir["**/file_parser_spec.rb"].join)
        end

        it 'does not detect non files' do
          expect(subject.parse(['no-such-file.py'])).to be_empty
        end
      end

      describe '#id' do
        it 'has correct form' do
          expect(subject.id).to eql :files
        end
      end
    end
  end
end
