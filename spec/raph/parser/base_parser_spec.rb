require 'spec_helper'

module Raph
  module Parser
    describe BaseParser do
      describe '#id' do
        it 'returns correct value for base class' do
          expect(subject.id).to eql :bases
        end

        it 'returns correct value for child class' do
          class BaseArgumentParser < BaseParser; end
          expect(BaseArgumentParser.new.id).to eql :base_arguments
        end

        it 'returns correct value for modulized class' do
          module A
            module B
              class TestParser < BaseParser; end
            end
          end
          expect(A::B::TestParser.new.id).to eql :tests
        end

        it 'is correct when no name convention' do
          class Plural < BaseParser; end
          expect(Plural.new.id).to eql :plurals
        end

        it 'can be redefined' do
          class Plural < BaseParser
            def id
              :tests
            end
          end
          expect(Plural.new.id).to eql :tests
        end
      end

      describe '#parse' do
        it 'should be implemented in descendant class' do
          expect { subject.parse [1, 2, 3] }.to raise_error NotImplementedError
        end
      end
    end
  end
end
