# raph [![Gem Version](https://badge.fury.io/rb/raph.svg)](https://rubygems.org/gems/raph) [![Build Status](https://api.travis-ci.org/veelenga/raph.svg?branch=master)](https://travis-ci.org/veelenga/raph)

![This is Raph](http://upload.wikimedia.org/wikipedia/en/5/58/TMNTRaphael2012.png)

**R**uby **A**rgument **P**arsing for **H**umans

Inspired by [args](https://github.com/kennethreitz/args)

## Installation:

`$ gem install raph`


## Usage:

Here is application sample:

```ruby
# sample.rb
require 'raph'

puts "Arguments passed in:  #{$raph.all}"
puts "Flags detected:       #{$raph.flags}"
puts "Files detected:       #{$raph.files}"
puts "Assignments detected: #{$raph.assignments}"
```

If you do not pass any arguments:

```sh
$ ruby sample.rb
Arguments passed in:  []
Flags detected:       []
Files detected:       []
Assignments detected: []
```

If you have few arguments passed:

```sh
$ ruby sample.rb -v --flag1 --flag2 --formatter=simple --convert=true
Arguments passed in:  ["-v", "--flag1", "--flag2", "--formatter=simple", "--convert=true"]
Flags detected:       ["-v", "--flag1", "--flag2"]
Files detected:       []
Assignments detected: ["--formatter=simple", "--convert=true"]
```

And finnaly if you pass expanded arguments:

```sh
$ ruby sample.rb -f spec/*.rb
Arguments passed in:  ["-f", "spec/raph_spec.rb", "spec/spec_helper.rb"]
Flags detected:       ["-f"]
Files detected:       ["spec/raph_spec.rb", "spec/spec_helper.rb"]
Assignments detected: []
```

## Advanced usage:

You can use `raph` with custom parsers. For example:

```ruby
require 'raph'

include Raph

class AnimalParser < BaseParser
  ANIMALS = ['cat', 'dog', 'pig', 'bear', 'elephant']

  def id
    :animals
  end

  def parse(args)
    animals = []
    args.each do |arg|
      animals << arg if ANIMALS.include? arg.strip.downcase
    end
    animals
  end
end

args = [ '--my-animals', 'cat', 'bird', 'dog', 'elephant' ]

raph = Raph::Raph.new.tap do |r|
  r.add_parser( AnimalParser.new )
  r.parse( args )
end

# Raph#animals attribute is added dynamically.
# It is defined by AnimalParser#id method.
puts "All:        #{raph.all}"
puts "My animals: #{raph.animals}"

#All:        ["--my-animals", "cat", "bird", "dog", "elephant"]
#My animals: ["cat", "dog", "elephant"]

```

## TODO:
 - Grouped arguments parser.
 - Not-files parser.

