#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/).captures

    {
        'suenum' => caps[0].to_i,
        caps[1] => caps[2].to_i,
        caps[3] => caps[4].to_i,
        caps[5] => caps[6].to_i
    }
end

def match?(sue, aunts)
    aunts.each do |aunt|
        if sue[aunt[0]] && sue[aunt[0]] != aunt[1]
            return false
        end
    end

    true
end

aunts = [
    ['children', 3],
    ['cats', 7],
    ['samoyeds', 2],
    ['pomeranians', 3],
    ['akitas', 0],
    ['vizslas', 0],
    ['goldfish', 5],
    ['trees', 3],
    ['cars', 2],
    ['perfumes', 1]
]

puts input.find { |sue| match?(sue, aunts) }['suenum']

