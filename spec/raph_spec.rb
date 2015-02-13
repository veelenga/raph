require 'spec_helper'

module Raph
  describe Raph do
    let(:flags) { ['-h', '--flag'] }
    let(:assignments) { ['-a=1', '--ass=2'] }
    let(:no_args) { ['-notaflag', '--h'] }

    let(:args) { flags + assignments + no_args}

    it 'has global variable' do
      raph = $raph
      expect(raph).not_to be nil
      expect(raph).to be_a Raph
    end

    context "when raph is created with non-args" do
      let(:raph) { Raph.new(no_args) }

      it 'flags are empty' do
        expect(raph.flags).to be_empty
      end

      it 'assignments are empty' do
        expect(raph.assignments).to be_empty
      end
    end

    context "when raph is created with args" do
      let(:raph) { Raph.new(args) }

      it 'parses flags' do
        expect(raph.flags).to match_array(flags)
      end

      it 'parses assignments' do
        expect(raph.assignments).to match_array(assignments)
      end
    end
  end
end
