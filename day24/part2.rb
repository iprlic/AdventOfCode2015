#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map(&:to_i)

group_weight = input.sum / 4

def find_combinations(input, group_weight, group_size)
    input.combination(group_size).select { |c| c.sum == group_weight }
end

group_size = 1
while true
    combinations = find_combinations(input, group_weight, group_size)
    break unless combinations.empty?

    group_size += 1
end

puts combinations.map { |c| c.reduce(:*) }.min
