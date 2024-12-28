#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
lights = File.read(file_path).split("\n").map(&:chars)

def step(lights)
    new_lights = lights.map(&:dup)

    lights.each_with_index do |row, y|
        row.each_with_index do |light, x|
            neighbours = []
            neighbours << lights[y - 1][x - 1] if y > 0 && x > 0
            neighbours << lights[y - 1][x] if y > 0
            neighbours << lights[y - 1][x + 1] if y > 0 && x < lights[y].length - 1
            neighbours << lights[y][x - 1] if x > 0
            neighbours << lights[y][x + 1] if x < lights[y].length - 1
            neighbours << lights[y + 1][x - 1] if y < lights.length - 1 && x > 0
            neighbours << lights[y + 1][x] if y < lights.length - 1
            neighbours << lights[y + 1][x + 1] if y < lights.length - 1 && x < lights[y].length - 1
           
            neighbours_cnt = neighbours.count('#')

            if light == '#'
                new_lights[y][x] = '.' if neighbours_cnt != 2 && neighbours_cnt != 3
            else
                new_lights[y][x] = '#' if neighbours_cnt == 3
            end
        end
    end

    new_lights[0][0] = '#'
    new_lights[0][-1] = '#'
    new_lights[-1][0] = '#'
    new_lights[-1][-1] = '#'

    new_lights
end

lights[0][0] = '#'
lights[0][-1] = '#'
lights[-1][0] = '#'
lights[-1][-1] = '#'

100.times do
    lights = step(lights)
end

puts lights.flatten.count('#')