require 'spec_helper'

module Raph
  module Parser
    describe GroupedArgParser do
      describe '#id' do
        it 'has correct form' do
          expect(subject.id).to eq :grouped_args
        end
      end

      describe '#parse' do
        it 'returns groups' do
          parsed = subject.parse(['-s', '1', '2', '3', '--assignment=one'])
          expect(parsed.size).to be 2
          expect(parsed).to include(:s => ['1', '2', '3'])
          expect(parsed).to include(:'assignment=one' => [])
        end

        it 'returns empty hash when group not found' do
          parsed = subject.parse(['1', '2', '3', 'one', 'two'])
          expect(parsed).to be_a Hash
          expect(parsed).to be_empty
        end

        it 'returns empty hash when there are no parameters' do
          parsed = subject.parse([])
          expect(parsed).to be_a Hash
          expect(parsed).to be_empty
        end

        it 'selects only arguments that belongs to the group' do
          parsed = subject.parse(['one', 'two', '-f', 'three', 'four'])
          expect(parsed.size).to be 1
          expect(parsed).to include(:f => ['three', 'four'])
        end
      end

      describe '#group?' do
        def group?(option)
          subject.group?(option)
        end

        it 'is a group' do
          positive_options = ['-h', '--help', '--assignment=true']
          positive_options.each do |option|
            expect(group? option).to be true
          end
        end

        it 'is not a group' do
          negative_options = ['', '-', '--', ' ', 'option', '1', '-assign=', '=']
          negative_options.each do |option|
            expect(group? option).to be false
          end
        end
      end
    end
  end
end
