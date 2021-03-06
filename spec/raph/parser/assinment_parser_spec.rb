require 'spec_helper'

module Raph
  module Parser
    describe AssignmentParser do
      describe '#id' do
        it 'has correct form' do
          expect(subject.id).to eq :assignments
        end
      end

      describe '#parse' do
        it 'returns assignments only' do
          parsed = subject.parse(['-h', '-on=20', '--two=my-file'])
          expect(parsed).to include(:on => '20', :two => 'my-file')
        end

        it 'has no to return assignments here' do
          expect(subject.parse(['-h', 'file', '=', '123'])).to be_empty
          expect(subject.parse([])).to be_empty
        end
      end

      describe '#assignment?' do
        def ass?(option)
          subject.assignment? option
        end

        it 'is an assignment' do
          expect(ass? 'h=one').to be true
          expect(ass? '-ass=two').to be true
          expect(ass? '--ass=two').to be true
        end

        it 'is not as assignment' do
          expect(ass? '-h').to be false
          expect(ass? '-h=').to be false
          expect(ass? 'h=').to be false
          expect(ass? '=').to be false
          expect(ass? '-h=one=two').to be false
        end
      end
    end
  end
end
