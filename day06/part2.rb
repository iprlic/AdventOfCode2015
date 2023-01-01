#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

instructions = input.map do |line|
    res = line.match(/^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)$/)

    {
        action: res[1],
        x1: res[2].to_i,
        y1: res[3].to_i,
        x2: res[4].to_i,
        y2: res[5].to_i
    }
end

grid = Array.new(1000) { Array.new(1000, 0) }

instructions.each do |instruction|
    (instruction[:x1]..instruction[:x2]).each do |x|
        (instruction[:y1]..instruction[:y2]).each do |y|
            case instruction[:action]
            when 'turn on'
                grid[x][y] += 1
            when 'turn off'
                grid[x][y] -= 1 if grid[x][y] > 0
            when 'toggle'
                grid[x][y] += 2
            end
        end
    end
end

puts grid.flatten.reduce(:+)