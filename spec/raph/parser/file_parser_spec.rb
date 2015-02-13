require 'spec_helper'

require 'raph/parser/file_parser'

module Raph
  module Parser
    describe FileParser do
      it 'detects files' do
        expect(FileParser.new(['**/*.rb']).parse).to include(Dir["**/file_parser_spec.rb"].join)
      end

      it 'does not detect non files' do
        expect(FileParser.new(['no-such-file.py']).parse).to be_empty
      end
    end
  end
end
