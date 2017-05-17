# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'pry'

csv_skill = File.read(Rails.root.join('lib', 'seeds', 'list_skill.csv'))
csv_skill_parse = CSV.parse(csv_skill, :headers => true, :encoding => 'ISO-8859-1')
csv_skill_parse.each do |row|
  t = Skill.new
  t.name = row['name']
  t.power = row['power']
  t.max_pp = row['max_pp']
  t.element_type = row['element_type'].upcase_first
  t.save
end
puts "Total skill : #{Skill.count}"

csv_pokedex = File.read(Rails.root.join('lib', 'seeds', 'list_pokedex.csv'))
csv_pokedex_parse = CSV.parse(csv_pokedex, :headers => true, :encoding => 'ISO-8859-1')
csv_pokedex_parse.each do |row|
  t = Pokedex.new
  t.name = row['name']
  t.base_health_point = row['base_health_point']
  t.base_attack = row['base_attack']
  t.base_defence = row['base_defence']
  t.base_speed = row['base_speed']
  t.element_type = row['element_type'].upcase_first
  t.image_url = row['image_url']
  t.save
end
puts "Total Pokedex : #{Pokedex.count}"
