# pokemon.com no longer serves 670_f2.png (404); point Floette-Eternal at PokeAPI's official artwork.
class FixFloetteEternalImage < ActiveRecord::Migration[8.1]
  OLD_URL = "http://assets.pokemon.com/assets/cms2/img/pokedex/full/670_f2.png"
  NEW_URL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10061.png"

  def up
    execute "UPDATE pokedexes SET image_url = #{quote(NEW_URL)} WHERE image_url = #{quote(OLD_URL)}"
  end

  def down
    execute "UPDATE pokedexes SET image_url = #{quote(OLD_URL)} WHERE image_url = #{quote(NEW_URL)}"
  end

  private

  def quote(value) = connection.quote(value)
end
