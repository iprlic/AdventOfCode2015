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

def replace(molecule, replacements)
    molecules = []

    replacements.each do |rpl|
        molecule.gsub(/#{rpl[:from]}/).map { Regexp.last_match.begin(0) }.each do |match|
            molecules << molecule[0...match] + rpl[:to] + molecule[match + rpl[:from].length..-1]
        end
    end

    molecules
end

puts replace(molecule, replacements).uniq.length