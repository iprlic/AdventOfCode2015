#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

sum = 0

input.each do |line|
    dims = line.split('x').map(&:to_i)

    dim1 = 2 * dims[0] * dims[1] 
    dim2 = 2 * dims[1] * dims[2]
    dim3 = 2 * dims[2] * dims[0]
    
    sum += dim1 + dim2 + dim3 + [dim1, dim2, dim3].min / 2
end

puts sum