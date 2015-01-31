require 'spec_helper'

describe Raph::ArgList do


  describe '#flag?' do

    def flag? option
      not subject.flag?(option).nil?
    end

    it 'is a flag' do
      expect(flag? '-h').to be true
      expect(flag? '-T').to be true
      expect(flag? '--config').to be true
      expect(flag? '--my-flag').to be true
    end

    it 'is not a flag' do
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
