#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n\n")

replacements = input[0].split("\n").map do |line|
    rpl = line.split(' => ')

    {
        from: rpl[0],
        to: rpl[1]
    }
end

molecule = input[1]
medicine = 'e'

reverses = { }
replacements.each do |r|
    reverses[r[:to]] ||= []
    reverses[r[:to]] << r[:from]
end

cnt = 0
reverses = reverses.sort_by { |k, v| -k.length }.to_h

while molecule != medicine
    reverses.each do |k, v|
        if molecule.include?(k)
            molecule.sub!(k, v.sample)
            cnt += 1
            break
        end
    end
end

puts cnt