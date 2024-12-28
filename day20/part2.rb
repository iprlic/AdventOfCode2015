#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).to_i

def factors(n)
    (1..Math.sqrt(n)).select { |i| (n % i).zero? }.inject([]) do |f, i|
        f << i
        f << n / i unless i == n / i
        f
    end
end

house = 0
presents = 0

while presents < input
    house += 1
    factors = factors(house)
    factors.select! { |f| house / f <= 50 }
    presents = factors.sum * 11
end

puts house
