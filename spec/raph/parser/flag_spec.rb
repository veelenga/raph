require 'spec_helper'

module Raph
  module Parser
    describe Flag do
      describe '#id' do
        it 'is not nil' do
          expect(Flag.id).not_to be nil
        end

        it 'is always the same' do
          expect(Flag.id).to eq(Flag.id)
        end
      end

      describe '#parse' do
        it 'finds flags only' do
          expect(Flag.new(['-h', '-9', '123', '--config', 'config.xml']).parse)\
            .to match_array(['-h', '-9', '--config'])
        end

        it 'has no flags here' do
          expect(Flag.new(['true', '-', '123']).parse).to match_array([])
          expect(Flag.new([]).parse).to match_array([])
        end
      end

      describe '#flag?' do
        let(:subj) { Flag.new(['opt1', '-h']) }

        def flag?(option)
          !subj.send(:flag?, option).nil?
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
