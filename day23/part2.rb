#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

registers = { a: 1, b: 0 }

i = 0
while i < input.size
    instr = input[i].split(' ')
    instr[1] = instr[1].chop if instr[1].end_with?(',')

    case instr[0]
    when 'hlf'
        registers[instr[1].to_sym] /= 2
        i += 1
    when 'tpl'
        registers[instr[1].to_sym] *= 3
        i += 1
    when 'inc'
        registers[instr[1].to_sym] += 1
        i += 1
    when 'jmp'
        i += instr[1].to_i
    when 'jie'
        if registers[instr[1].to_sym].even?
            i += instr[2].to_i
        else
            i += 1
        end
    when 'jio'
        if registers[instr[1].to_sym] == 1
            i += instr[2].to_i
        else
            i += 1
        end
    end
end

puts registers[:b]