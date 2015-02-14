require 'spec_helper'

module Raph
  module Parser
    describe FlagParser do
      describe '#id' do
        it 'has correct form' do
          expect(subject.id).to eq :flags
        end
      end

      describe '#parse' do
        it 'returns flags only' do
          expect(subject.parse(['-h', '-9', '123', '--config', 'config.xml'])).
            to match_array(['-h', '-9', '--config'])
        end

        it 'has no flags here' do
          expect(subject.parse(['true', '-', '123'])).to match_array([])
          expect(subject.parse([])).to match_array([])
        end
      end

      describe '#flag?' do
        def flag?(option)
          !subject.flag?(option).nil?
        end

        it 'is a flag' do
          expect(flag? '-h').to be true
          expect(flag? '-T').to be true
          expect(flag? '--config').to be true
          expect(flag? '--my-flag').to be true
        end

        it 'is not a flag?' do
          expect(flag? '').to be false
          expect(flag? '-').to be false
          expect(flag? '--').to be false
          expect(flag? '---').to be false
          expect(flag? '--h').to be false
          expect(flag? 'option').to be false
          expect(flag? '---option').to be false
        end
      end
    end
  end
end
