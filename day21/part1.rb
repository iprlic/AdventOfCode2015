#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

boss = { 
    hit_points: input[0].split(': ')[1].to_i,
    damage: input[1].split(': ')[1].to_i,
    armor: input[2].split(': ')[1].to_i
}

weapons = [
    { cost: 8, damage: 4, armor: 0 },
    { cost: 10, damage: 5, armor: 0 },
    { cost: 25, damage: 6, armor: 0 },
    { cost: 40, damage: 7, armor: 0 },
    { cost: 74, damage: 8, armor: 0 }
]

armors = [
    { cost: 13, damage: 0, armor: 1 },
    { cost: 31, damage: 0, armor: 2 },
    { cost: 53, damage: 0, armor: 3 },
    { cost: 75, damage: 0, armor: 4 },
    { cost: 102, damage: 0, armor: 5 },
    { cost: 0, damage: 0, armor: 0 }
]

rings = [
    { cost: 25, damage: 1, armor: 0 },
    { cost: 50, damage: 2, armor: 0 },
    { cost: 100, damage: 3, armor: 0 },
    { cost: 20, damage: 0, armor: 1 },
    { cost: 40, damage: 0, armor: 2 },
    { cost: 80, damage: 0, armor: 3 },
    { cost: 0, damage: 0, armor: 0 },
    { cost: 0, damage: 0, armor: 0 }
]

my_hit_points = 100

def fight(my_hit_points, my_damage, my_armor, boss)
    my_hp = my_hit_points
    boss_hp = boss[:hit_points].dup

    my_turn = true

    while my_hp > 0 && boss_hp > 0
        if my_turn
            boss_hp -= [1, my_damage - boss[:armor]].max
        else
            my_hp -= [1, boss[:damage] - my_armor].max
        end

        my_turn = !my_turn
    end

    my_hp > 0
end

min_cost = Float::INFINITY


weapons.each do |weapon|
    armors.each do |armor_option|
        rings.combination(2).each do |rings|
            ring1, ring2 = rings

            cost = weapon[:cost] + armor_option[:cost] + ring1[:cost] + ring2[:cost]
            damage = weapon[:damage] + armor_option[:damage] + ring1[:damage] + ring2[:damage]
            armor = weapon[:armor] + armor_option[:armor] + ring1[:armor] + ring2[:armor]

            if fight(my_hit_points, damage, armor, boss)
                min_cost = [cost, min_cost].min
            end
        end

    end
end

puts min_cost