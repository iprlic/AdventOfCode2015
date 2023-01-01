#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

cnt = 0

input.each do |line|
    cnt += 1 if line =~ /([aeiou].*){3}/ && line =~ /([a-z])\1/ && line !~ /ab|cd|pq|xy/
end

puts cnt