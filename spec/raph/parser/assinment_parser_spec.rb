require 'spec_helper'

module Raph
  module Parser
    describe AssignmentParser do
      describe '#parse' do
        it 'finds assignments only' do
          expect(AssignmentParser.new(['-h',
                                       '-on=20',
                                       '--two=my-file']).parse)\
            .to match_array(['-on=20', '--two=my-file'])
        end

        it 'has no assignments here' do
          expect(AssignmentParser.new(['-h', 'file', '=', '123']).parse)\
            .to match_array([])
          expect(AssignmentParser.new([]).parse).to match_array([])
        end
      end

      describe '#assignment?' do
        let(:subj) { AssignmentParser.new(['-h']) }

        def ass?(option)
          subj.send(:assignment?, option)
        end

        it 'is an assignment' do
          expect(ass? 'h=one').to be true
          expect(ass? '-ass=two').to be true
          expect(ass? '--ass=two').to be true
          expect(ass? 'ass=one=two').to be true
        end

        it 'is not as assignment' do
          expect(ass? '-h').to be false
          expect(ass? '-h=').to be false
          expect(ass? 'h=').to be false
          expect(ass? '=').to be false
        end
      end
    end
  end
end
