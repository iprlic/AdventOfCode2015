#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n").map do |line|
    caps = line.match(/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/).captures

    {
        name: caps[0],
        capacity: caps[1].to_i,
        durability: caps[2].to_i,
        flavor: caps[3].to_i,
        texture: caps[4].to_i,
        calories: caps[5].to_i
    }
end

def score_for_order(ingredients, order)
    order = order.map { |i| ingredients.find { |ingredient| ingredient[:name] == i } }

    capacity = order.map { |i| i[:capacity] }.sum
    durability = order.map { |i| i[:durability] }.sum
    flavor = order.map { |i| i[:flavor] }.sum
    texture = order.map { |i| i[:texture] }.sum
    calories = order.map { |i| i[:calories] }.sum

    return 0 if capacity <= 0 || durability <= 0 || flavor <= 0 || texture <= 0 || calories != 500

    capacity * durability * flavor * texture
end

def calories_for_order(ingredients, order)
    order = order.map { |i| ingredients.find { |ingredient| ingredient[:name] == i } }

    calories = order.map { |i| i[:calories] }.sum
end

ingredients = input.map { |i| i[:name] }

puts ingredients.repeated_combination(100).map { |order| score_for_order(input, order) }.max