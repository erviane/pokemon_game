class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy]

  def index
    @trainers = Trainer.all.order("created_at ASC").paginate(page: params[:page], per_page: 20)
  end

  def show
    @pokemons = @trainer.pokemons
    show_statistic
  end

  def new
    @trainer = Trainer.new
  end

  def edit
  end

  def create
    @trainer = Trainer.new(trainer_params)
      if @trainer.save
        redirect_to trainers_url
        flash[:success] = "New trainer was successfully created"
      else
        render :new
      end
  end

  def update
      if @trainer.update(trainer_params)
        redirect_to trainer_url
        flash[:success] = "trainer was successfully updated"
      else
        render :edit
      end
  end

  def destroy
      @trainer.destroy
      redirect_to trainers_url
      flash[:success] = "trainer was successfully destroyed"
  end

  private
    def set_trainer
      @trainer = Trainer.find(params[:id])
    end

    def trainer_params
      params.require(:trainer).permit(:name, :email, :password, :password_confirmation)
    end

    def show_statistic
        #most_win_pokemon
        most_win_pokemon

        #most_lose_pokemon
        most_lose_pokemon

        #most_used_pokemon
        most_used_pokemon

        #pokemon_ordered_win_rate
        pokemon_win_rate

        #pokemon_win_rate_by_element_type
        pokemon_win_rate_element
    end

    def most_win_pokemon
        sql_most_win_pokemon = ActiveRecord::Base.connection.execute("select pokemons.name, count(pokemon_battles.pokemon_winner_id) as pokemon_winner 
                                                              from pokemons left outer join pokemon_battles 
                                                              on pokemons.id = pokemon_battles.pokemon_winner_id 
                                                              where pokemons.trainer_id= #{@trainer.id}
                                                              group by pokemons.name 
                                                              order by pokemon_winner desc 
                                                              limit 1")
        @most_win_pokemon ={}
        sql_most_win_pokemon.each do |x| 
            x_name = x['name']
            @most_win_pokemon["#{x_name}"] = x['pokemon_winner']
        end
        if @most_win_pokemon.values == [0]
            @display_most_pokemon_win = "-"
        else
            @display_most_pokemon_win = @most_win_pokemon.keys.to_sentence
        end
    end

    def most_lose_pokemon
        sql_most_lose_pokemon = ActiveRecord::Base.connection.execute("select pokemons.name, count(pokemon_battles.pokemon_loser_id) as pokemon_loser 
                                                              from pokemons left outer join pokemon_battles 
                                                              on pokemons.id = pokemon_battles.pokemon_loser_id 
                                                              where pokemons.trainer_id= #{@trainer.id} 
                                                              group by pokemons.name 
                                                              order by pokemon_loser desc 
                                                              limit 1")
        @most_lose_pokemon ={}
        sql_most_lose_pokemon.each do |x| 
            x_name = x['name']
            @most_lose_pokemon["#{x_name}"] = x['pokemon_loser']
        end
        if @most_lose_pokemon.values == [0]
            @display_most_pokemon_lose = "-"
        else
            @display_most_pokemon_lose = @most_lose_pokemon.keys.to_sentence
        end
    end

    def most_used_pokemon
        sql_most_used_pokemon = ActiveRecord::Base.connection.execute("select name, sum(count) as sum_picked 
                                                                      from (
                                                                          select pokemons.name, count(pokemon_battles.pokemon_winner_id)
                                                                          from pokemons left outer join pokemon_battles
                                                                          on pokemons.id = pokemon_battles.pokemon_winner_id                                                                          
                                                                          where pokemons.trainer_id= #{@trainer.id} 
                                                                          group by pokemons.id
                                                                          UNION ALL
                                                                          select pokemons.name, count(pokemon_battles.pokemon_loser_id)
                                                                          from pokemons left outer join pokemon_battles 
                                                                          on pokemons.id = pokemon_battles.pokemon_loser_id                                                                          
                                                                          where pokemons.trainer_id= #{@trainer.id}
                                                                          group by pokemons.id
                                                                        ) 
                                                                      as pokemon_picked 
                                                                      group by name 
                                                                      order by sum_picked desc
                                                                      limit 1")
        @most_used_pokemon ={}
        sql_most_used_pokemon.each do |x| 
            x_name = x['name']
            @most_used_pokemon["#{x_name}"] = x['sum_picked']
        end
        if @most_used_pokemon.values == ["0"]
            @display_most_pokemon_used = "-"
        else
            @display_most_pokemon_used = @most_used_pokemon.keys.to_sentence
        end
    end

    def pokemon_win_rate
        @pokemon_win_rate = {}
        @trainer.pokemons.each do |x|
            count_win = PokemonBattle.where(pokemon_winner_id: x.id).count
            count_lose = PokemonBattle.where(pokemon_loser_id: x.id).count
            count_battle = count_win + count_lose
            if count_battle > 0 
                win_rate = (count_win / count_battle.to_f * 100).to_i
                @pokemon_win_rate[x.name] = win_rate
            else
                @pokemon_win_rate[x.name] = 0
            end
        end
        @display_pokemon_win_rate=  @pokemon_win_rate.sort_by{|key, value| - value}
    end

    def pokemon_win_rate_element
        @pokemon_win_rate_element = {}
        @win = {}
        @battle = {}
        @trainer.pokemons.each do |x|
            element_type = x.pokedex.element_type
            @pokemon_win_rate_element[element_type] = {}
            @win[element_type] = {}
            @battle[element_type] = {}
            battle_count_sql = ActiveRecord::Base.connection.execute("select name, sum(count) as sum_battle_element 
                                                                 from (
                                                                     select pokemons.name, count(pokemon_battles.pokemon1_id)
                                                                     from pokemons left outer join pokemon_battles
                                                                     on pokemons.id = pokemon_battles.pokemon_winner_id
                                                                     left outer join pokedexes
                                                                     on pokemons.pokedex_id = pokedexes.id                                                                          
                                                                     where pokemons.trainer_id= #{@trainer.id} 
                                                                     and pokedexes.element_type = '#{element_type}'                                                                        group by pokemons.id
                                                                     UNION ALL
                                                                     select pokemons.name, count(pokemon_battles.pokemon2_id)
                                                                     from pokemons left outer join pokemon_battles 
                                                                     on pokemons.id = pokemon_battles.pokemon_loser_id
                                                                     left outer join pokedexes
                                                                     on pokemons.pokedex_id = pokedexes.id                                                                          
                                                                     where pokemons.trainer_id= #{@trainer.id} 
                                                                     and pokedexes.element_type = '#{element_type}'
                                                                     group by pokemons.id
                                                                    ) 
                                                                 as pokemon_battle_element
                                                                 group by name
                                                                 order by sum_battle_element desc")
            win_count_sql =   ActiveRecord::Base.connection.execute("select name, sum(count) as sum_win_element 
                                                                from (
                                                                      select pokemons.name, count(pokemon_battles.pokemon1_id)
                                                                      from pokemons left outer join pokemon_battles
                                                                      on pokemons.id = pokemon_battles.pokemon_winner_id
                                                                      left outer join pokedexes
                                                                      on pokemons.pokedex_id = pokedexes.id                                                                          
                                                                      where pokemons.trainer_id= #{@trainer.id} 
                                                                      and pokedexes.element_type = '#{element_type}'
                                                                      group by pokemons.id) as pokemon_win_element
                                                                      group by name
                                                                      order by sum_win_element desc"
                                                                    )

            battle_count_sql.each do |x| 
                x_name = x['name']                
                @battle[element_type]["#{x_name}"] = x['sum_battle_element']
            end
            win_count_sql.each do |x| 
                x_name = x['name']                
                @win[element_type]["#{x_name}"] = x['sum_win_element']
            end

            @battle.keys.each do |x|
              @battle[x].each do |key,value|
                if @battle[x][key] == "0"
                  @pokemon_win_rate_element[x][key] = 0
                else
                  @pokemon_win_rate_element[x][key] = ((@win[x][key].to_f/@battle[x][key].to_f)*100).to_i
                end
              end
            end
        end
    end
end
