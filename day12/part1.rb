#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'

file_path = File.expand_path('input.txt', __dir__)
input = JSON.parse(File.read(file_path))

def sum_numbers(object)
    if object.is_a?(Hash)
        return object.values.map { |value| sum_numbers(value) }.sum
    elsif object.is_a?(Array)
        return object.map { |value| sum_numbers(value) }.sum
    elsif object.is_a?(Integer)
        return object
    else
        return 0
    end
end

puts sum_numbers(input)