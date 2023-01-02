#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/(.*) to (.*) = (.*)/).captures
    {
        from: caps[0],
        to: caps[1],
        distance: caps[2].to_i
    }
end

cities = input.map { |x| [x[:from], x[:to]] }.flatten.uniq


puts cities.permutation.map { |perm| perm.each_cons(2).map { |from, to| input.find { |x| (x[:from] == from && x[:to] == to) || (x[:to] == from && x[:from] == to)}[:distance] }.reduce(:+) }.max
