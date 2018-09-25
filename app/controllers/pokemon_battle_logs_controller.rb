class PokemonBattleLogsController < ApplicationController
	def index
		@pokemon_battle_logs = PokemonBattleLog.where("pokemon_battle_id=?", params[:pokemon_battle_id]).order("created_at ASC").paginate(page: params[:page], per_page: 20)
	end
end
