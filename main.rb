require "pry"
require_relative "lib/environment"

input = File.read("seed.txt")

puts '-' * 30
puts 'Earth Control Starting to process instructions'
puts input
puts '-' * 30


puts 'Earth Control Finished sequence resulting in'

earth_control = MartianRobots::EarthControl.new input: input
earth_control.execute!
puts earth_control.output