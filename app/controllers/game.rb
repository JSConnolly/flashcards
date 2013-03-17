post '/game' do                                          # called from profile.erb
Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    @round.prepare
    session[:remaining_cards] = @round.remaining_cards.length
    redirect "/game/#{@round.id}/#{@round.last_try}"
end

get '/game/:round/:last_try' do 
  @round = Round.find(params[:round])
  run_game(@round)  # find me in helpers under game_logic.rb               
end

get '/game_over/:round_id' do
  @round = Round.find(params[:round_id])
  erb :game_over
end

post '/guess' do  
  @round = Round.find(params[:round_id])
  @round.guess(params[:answer], session[:current_card_id])
  redirect "/game/#{@round.id}/#{@round.last_try}"
end