class PokemonBattleLogsController < ApplicationController
	def index
		@pokemon_battle_logs = PokemonBattleLog.where(pokemon_battle_id: params[:pokemon_battle_id]).search(params[:q]).with_action(params[:action_type])
		                                       .sorted(params[:sort], params[:dir], PokemonBattleLog::SORTS, default: "pokemon_battle_logs.created_at ASC").paginate(page: params[:page], per_page: 20)
	end
end
