#!/usr/bin/env ruby
# frozen_string_literal: true

file_path = File.expand_path('input.txt', __dir__)
input = File.read(file_path).split("\n")

boss = { 
    hit_points: input[0].split(': ')[1].to_i,
    damage: input[1].split(': ')[1].to_i,
}

$spells = [
    { cost: 53, damage: 4, armor: 0, heal: 0, mana: 0, duration: 0, name: 'Magic Missile' },
    { cost: 73, damage: 2, armor: 0, heal: 2, mana: 0, duration: 0, name: 'Drain' },
    { cost: 113, damage: 0, armor: 7, heal: 0, mana: 0, duration: 6, name: 'Shield' },
    { cost: 173, damage: 3, armor: 0, heal: 0, mana: 0, duration: 6, name: 'Poison' },
    { cost: 229, damage: 0, armor: 0, heal: 0, mana: 101, duration: 5, name: 'Recharge' }
]

my_hit_points = 50
my_mana = 500


def fight(my_hp, my_mana, my_mana_spent, boss_hp, boss_damage, effects, my_turn, victory = nil)
    my_armor = 0

    my_hp -= 1 if my_turn
    if my_hp <= 0
        return [[my_hp, my_mana, my_mana_spent, boss_hp, boss_damage, [], !my_turn, false]]
    end

    current_effects = []
    effects.each do |e|
        boss_hp -= e[:damage]
        my_hp += e[:heal]
        my_mana += e[:mana]
        my_armor += e[:armor]
        new_duration = e[:duration].dup - 1

        if new_duration > 0
            current_effects << { cost: e[:cost].dup, damage: e[:damage].dup, armor: e[:armor].dup, heal: e[:heal].dup, mana: e[:mana].dup, duration: new_duration, name: e[:name].dup }
        end
    end

    if boss_hp <= 0
        return [[my_hp, my_mana, my_mana_spent, boss_hp, boss_damage, current_effects, !my_turn, true]]
    end

    new_possible_outcomes = []
    if my_turn
        possible_spells = $spells.select { |s| s[:cost] <= my_mana && !current_effects.any? { |e| e[:name] == s[:name] } }

        if possible_spells.empty?
            return [[my_hp, my_mana, my_mana_spent, boss_hp, boss_damage, current_effects, !my_turn, false]]
        else

            possible_spells.each do |spell|
                new_effects = current_effects.dup
                new_effects << spell.dup if spell[:duration] > 0 

                new_my_mana = my_mana - spell[:cost]
                new_boss_hp = boss_hp - (spell[:duration] > 0 ? 0 : spell[:damage])
                new_my_mana_spent = my_mana_spent + spell[:cost]
                my_new_hp = my_hp + spell[:heal]

                victory = new_boss_hp <= 0 ? true : nil

                new_possible_outcomes << [my_new_hp, new_my_mana, new_my_mana_spent, new_boss_hp, boss_damage, new_effects, !my_turn, victory]
            end

            return new_possible_outcomes
        end
    else
        my_hp -= [1, boss_damage - my_armor].max
        victory = my_hp <= 0 ? false : nil

        new_possible_outcomes << [my_hp, my_mana, my_mana_spent, boss_hp, boss_damage, current_effects, !my_turn, victory]
        return new_possible_outcomes
    end
    
end




current_outcomes = [[my_hit_points, my_mana, 0, boss[:hit_points], boss[:damage], [], true, nil]]
completed_outcomes = []

cnt = 0
loop do
    new_outcomes = []
    current_outcomes.each do |outcome|
        new_current_outcomes = fight(*outcome)

        new_completed_outcomes = new_current_outcomes.select { |o| o[7].nil? == false }
        new_not_completed_outcomes = new_current_outcomes.select { |o| o[7].nil? }
        
        new_outcomes.concat(new_not_completed_outcomes)
        completed_outcomes.concat(new_completed_outcomes)
    end

    current_outcomes = new_outcomes.uniq

    break if current_outcomes.empty?
    cnt += 1
end

puts completed_outcomes.select { |o| o[7] == true }.map { |o| o[2] }.min