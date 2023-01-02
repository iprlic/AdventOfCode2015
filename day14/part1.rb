#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/(.* can fly )(\d+)( km\/s for )(\d+)( seconds, but then must rest for )(\d+)( seconds\.)$/).captures

    {
        name: caps[0].strip,
        speed: caps[1].to_i,
        flight_time: caps[3].to_i,
        rest_time: caps[5].to_i
    }
end

def distance_after_time(time, speed, flight_time, rest_time)
    cycle_time = flight_time + rest_time
    cycles = time / cycle_time
    remaining_time = time % cycle_time

    cycles * speed * flight_time + [remaining_time, flight_time].min * speed
end

puts input.map { |reindeer| distance_after_time(2503, reindeer[:speed], reindeer[:flight_time], reindeer[:rest_time]) }.max
