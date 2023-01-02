#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map(&:to_i)

liters = 150

def combinations_for_volume(eggnog, volume)
    return 1 if volume == 0
    return 0 if eggnog.empty?

    combinations_for_volume(eggnog[1..-1], volume) +
        combinations_for_volume(eggnog[1..-1], volume - eggnog[0])
end

puts combinations_for_volume(input, liters)