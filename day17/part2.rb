#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map(&:to_i)

liters = 150

def containers_for_volume(eggnog, volume)
    return [[]] if volume == 0
    return [] if eggnog.empty?

    containers_for_volume(eggnog[1..-1], volume) +
        containers_for_volume(eggnog[1..-1], volume - eggnog[0]).map { |c| [eggnog[0]] + c }
end

container_combinations = containers_for_volume(input, liters)

min_containers = container_combinations.min_by(&:length).length

puts container_combinations.count { |c| c.length == min_containers }
