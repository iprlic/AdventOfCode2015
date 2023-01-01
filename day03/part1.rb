#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).chars

x = 0
y = 0

houses = { [x, y] => 1 }

input.each do |char|
    case char
    when '^'
        y += 1
    when 'v'
        y -= 1
    when '>'
        x += 1
    when '<'
        x -= 1
    end

    houses[[x, y]] = 1 if houses[[x, y]].nil?
    houses[[x, y]] += 1
end

puts houses.length

