#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

cnt_chars = 0
cnt_code = 0

input.each do |line|
    cnt_code += line.length
    
    line.gsub!("\\", "\\\\\\")
    line = line.gsub("\"", "\\\"")

    cnt_chars += line.length + 2
end


puts cnt_chars-cnt_code
