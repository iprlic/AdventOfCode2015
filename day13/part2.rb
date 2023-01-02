#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/(.*) would (gain|lose) (\d+) happiness units by sitting next to (.*)\./).captures

    {
        person: caps[0],
        happiness: caps[2].to_i * (caps[1] == 'gain' ? 1 : -1),
        neighbour: caps[3]
    }
end

people = input.map { |line| line[:person] }.uniq

input += people.map { |person| { person: person, happiness: 0, neighbour: 'me' } }
input += people.map { |person| { person: 'me', happiness: 0, neighbour: person } }

people << 'me'

def happiness_for_order(people, input)
    arr_sum = people.each_cons(2).map do |person, neighbour|
        input.find { |line| line[:person] == person && line[:neighbour] == neighbour }[:happiness] +
            input.find { |line| line[:person] == neighbour && line[:neighbour] == person }[:happiness]
    end.sum

    arr_sum + input.find { |line| line[:person] == people.first && line[:neighbour] == people.last }[:happiness] +
        input.find { |line| line[:person] == people.last && line[:neighbour] == people.first }[:happiness]
end

puts people.permutation.map { |order| happiness_for_order(order, input) }.max
