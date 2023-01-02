#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path)


50.times do
    input.gsub!(/(.)\1*/) { |match| "#{match.length}#{match[0]}" }
end

puts input.length