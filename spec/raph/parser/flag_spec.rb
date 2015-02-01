require 'spec_helper'

module Raph
  module Parser
    describe Flag do
      describe '#id' do
        it 'is not nil' do
          expect(Flag.new([]).parse).not_to be nil
        end
      end
    end
  end
end
