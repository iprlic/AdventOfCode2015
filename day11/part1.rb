#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path)

def increment_password(password)
    password = password.reverse
    next_password = []
    increment = true

    password.chars.each do |char|
        if not increment
            next_password << char
            next
        end
        if char == "z"
            next_password << "a"
        else
            next_password << (char.ord + 1).chr
            increment = false
        end
    end

    next_password.reverse.join
end


def valid_password?(password)
    if password =~ /[iol]/
        return false
    end

    if password !~ /(.)\1.*(.)\2/
        return false
    end

    return false if !password.chars.each_cons(3).any? { |a, b, c| a.ord + 1 == b.ord && b.ord + 1 == c.ord }
    
    true
end

def next_password(password)
    password = increment_password(password)
    until valid_password?(password)
        password = increment_password(password)
    end
    password
end

puts next_password(input)
