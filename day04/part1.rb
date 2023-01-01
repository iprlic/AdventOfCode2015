#!/usr/bin/env ruby
# frozen_string_literal: true

require 'digest/md5'

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path)

candidate = 0

loop do
    candidate += 1
    break if Digest::MD5.hexdigest("#{input}#{candidate}").start_with?('00000')
end

puts candidate

