#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/(.* can fly )(\d+)( km\/s for )(\d+)( seconds, but then must rest for )(\d+)( seconds\.)$/).captures

    {
        name: caps[0].strip,
        speed: caps[1].to_i,
        flight_time: caps[3].to_i,
        rest_time: caps[5].to_i,
        points: 0
    }
end

def distance_after_time(time, speed, flight_time, rest_time)
    cycle_time = flight_time + rest_time
    cycles = time / cycle_time
    remaining_time = time % cycle_time

    cycles * speed * flight_time + [remaining_time, flight_time].min * speed
end

(1..2503).each do |time|
    input.each do |reindeer|
        reindeer[:distance] = distance_after_time(time, reindeer[:speed], reindeer[:flight_time], reindeer[:rest_time])
    end

    max_distance = input.map { |reindeer| reindeer[:distance] }.max
    input.each do |reindeer|
        reindeer[:points] += 1 if reindeer[:distance] == max_distance
    end
end

puts input.map { |reindeer| reindeer[:points] }.max