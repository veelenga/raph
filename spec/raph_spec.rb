require 'spec_helper'
require 'fileutils'

module Raph
  describe Raph do
    let(:flags) { ['-h', '--flag'] }
    let(:assignments) { ['-a=1', '--ass=2'] }
    let(:files) { ['test1.rb', 'test2.rb'] }
    let(:no_args) { ['-notaflag', '--h'] }

    let(:args) { flags + assignments + files + no_args}

    it 'has global variable' do
      raph = $raph
      expect(raph).not_to be nil
      expect(raph).to be_a Raph
    end

    context "when raph is created with non-args" do
      let(:raph) { Raph.new(no_args) }

      it 'does not return flags' do
        expect(raph.flags).to be_empty
      end

      it 'does not return assignments' do
        expect(raph.assignments).to be_empty
      end

      it 'does not return files' do
        expect(raph.files).to be_empty
      end
    end

    context 'when raph is created with args' do
      let(:raph) { Raph.new(args) }

      it 'parses flags' do
        expect(raph.flags).to match_array(flags)
      end

      it 'parses assignments' do
        expect(raph.assignments).to match_array(assignments)
      end

      context 'when files exist' do
        before do
          files.each do |name|
            FileUtils.touch name
          end
        end

        after do
          files.each do |name|
            FileUtils.rm_r name
          end
        end

        it 'detects those files' do
          expect(raph.files).to match_array(files)
        end
      end

    end
  end
end
