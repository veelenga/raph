require 'spec_helper'

module Raph
  module Parser
    describe BaseParser do
      describe '#parse' do
        it 'is always nil' do
          expect(subject.parse).to be nil
        end
      end
    end
  end
end
