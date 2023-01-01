#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

cnt_chars = 0
cnt_code = 0

input.each do |line|
    cnt_code += line.length
    
    line.scan(/\\x[0-9a-f]{2}/) do |m|
        line = line.sub(m, '1')
    end

    line.scan(/\\\\/) do |m|
        line = line.sub(m, '1')
    end

    line.scan(/\\"/) do |m|
        line = line.sub(m, '1')
    end

    cnt_chars += line.length - 2
end


puts cnt_code - cnt_chars
