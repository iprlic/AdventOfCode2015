#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).chars

x1 = 0
y1 = 0

x2 = 0
y2 = 0

houses = { [x1, y1] => 2 }


input.each_with_index do |char, index|
    if index.even?
        x = x1
        y = y1
    else
        x = x2
        y = y2
    end

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

    if index.even?
        x1 = x
        y1 = y
    else
        x2 = x
        y2 = y
    end
end

puts houses.length