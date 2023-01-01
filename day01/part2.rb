#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).chars

sum = 0

input.each_with_index do |char, index|
    sum += (char == '(' ? 1 : -1)
    if sum == -1
        puts index + 1
        break
    end
end