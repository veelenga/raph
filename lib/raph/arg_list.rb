module Raph
  class ArgList
    attr_reader :all, :files, :flags

    def initialize(args)
      @args = args
    end

    private

    def parse
      @args.each do

      end
    end

    # Considers option as flag if an only if
    # it's name starts with one dash and follows by
    # one word character or starts with two dashes
    # and follows by 2 or more word chacters or dashes.
    #
    # Assumes that option doesn't have spaces.
    #
    # Example of flags:
    #   '-h' '-text' '--config'
    #
    # Example of non-flags:
    #   'option' '---option2' '--h'
    def flag?(option)
      option =~ /^-[\w]$/ or option =~ /^--[\w][\w-]+$/
    end
  end
end

raph = Raph::ArgList.new(ARGV)
p ARGV
puts "All args: #{raph.all}"
puts "Files   : #{raph.files}"
puts "Flags   : #{raph.flags}"
