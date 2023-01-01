#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

instructions = input.map do |line|
    connectin = line.match(/(.*) -> (.*)/)
    {
        input: connectin[1].split(' '),
        output: connectin[2]
    }
end

wires = {}
executed_instructions = {}

while executed_instructions.size < instructions.size
    instructions.each_with_index do |instruction, index|
        next if executed_instructions[index]
        if instruction[:input].size == 1
            if instruction[:input][0] =~ /[0-9]/
                wires[instruction[:output]] = instruction[:input][0].to_i
                executed_instructions[index] = true
            else
                next if wires[instruction[:input][0]].nil?
                wires[instruction[:output]] = wires[instruction[:input][0]]
                executed_instructions[index] = true
            end
        elsif instruction[:input].size == 2
            next if wires[instruction[:input][1]].nil?
            wires[instruction[:output]] = ~wires[instruction[:input][1]]
            executed_instructions[index] = true
        elsif instruction[:input].size == 3
            a = -1
            b = -1
            if instruction[:input][0] =~ /[0-9]/
                a = instruction[:input][0].to_i
            else
                a = wires[instruction[:input][0]]
                next if a.nil?
            end

            if instruction[:input][2] =~ /[0-9]/
                b = instruction[:input][2].to_i
            else
                b = wires[instruction[:input][2]]
                next if b.nil?
            end
            case instruction[:input][1]
            when 'AND'
                wires[instruction[:output]] = a & b
            when 'OR'
                wires[instruction[:output]] = a | b
            when 'LSHIFT'
                wires[instruction[:output]] = a << b
            when 'RSHIFT'
                wires[instruction[:output]] = a >> b
            end
            executed_instructions[index] = true
        end
    end

end

puts wires['a']