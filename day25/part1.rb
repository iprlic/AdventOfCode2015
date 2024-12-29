#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).scan(/\d+/).map(&:to_i)

row = input[0]
column = input[1]

n = (row + column - 1) * (row + column - 2) / 2 + column
code = 20151125

(n - 1).times do
    code = (code * 252533) % 33554393
end

puts code
