require 'raph'

puts "Arguments passed in:  #{$raph.all}"
puts "Flags detected:       #{$raph.flags}"
puts "Files detected:       #{$raph.files}"
puts "Assignments detected: #{$raph.assignments}"
puts "Grouped argumentes:   #{$raph.grouped_args}"
