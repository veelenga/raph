require 'spec_helper'
require 'fileutils'

module Raph
  describe Raph do

    class NumberParser
      attr_accessor :id, :max

      def initialize(id, max=100)
        @id = id
        @max = max
      end

      def parse(args)
        args.select { |x| x <= max }
      end
    end

    describe '#parse' do
      let (:numbers) { (1..100) }
      let (:parser1) { NumberParser.new(:first, 5) }
      let (:parser2) { NumberParser.new(:second, 6) }

      it 'should parse nothing if parsers not added' do
        raph = Raph.new.tap { |r| r.parse numbers }
        expect(raph.all).to match_array numbers
      end

      it 'should have correspoding attribute if parser added' do
        raph = Raph.new.tap do |r|
          r.add_parser(parser1)
          r.add_parser(parser2)
          r.parse(numbers)
        end
        expect(raph.all).to match_array numbers
        expect(raph.send(parser1.id)).to match_array (1..parser1.max)
        expect(raph.send(parser2.id)).to match_array (1..parser2.max)
      end
    end
  end

  context 'when we include Raph' do
    it 'loads global variable' do
      expect($raph).to be_a Raph
    end

    it 'has proper attributes' do
      raph = $raph
      expect(raph.all).not_to be nil
      expect(raph.send(FlagParser.new.id)).not_to be nil
      expect(raph.send(FileParser.new.id)).not_to be nil
      expect(raph.send(AssignmentParser.new.id)).not_to be nil
    end
  end
end
