#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).chars

puts input.reduce(0) { |sum, char| sum + (char == '(' ? 1 : -1) }