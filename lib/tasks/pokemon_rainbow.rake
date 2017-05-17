namespace :pokemon_rainbow do
  desc 'Drop, create, migrate then seed the development database'
  task dropandseed: [ 'db:drop', 'db:create', 'db:migrate', 'db:seed' ] do
    puts 'Reseeding completed.'
  end
end