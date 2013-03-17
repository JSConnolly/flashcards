post '/game' do  # called from profile.erb. Starts the game by passing in the deck user has chosen from dropdown
Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    @round.prepare
    redirect "/game/#{@round.id}/#{@round.last_try}/#{@round.remaining_cards.length}"
end

get '/game/:round/:last_try/:remaining_cards' do
  @round = Round.find(params[:round])
  unless params[:remaining_cards] == '0'
    @round.prepare(params[:remaining_cards]) 
    @last_card = @round.current_card
    @round.next_card
    session[:current_card_id] = @round.current_card.id
    @card = @round.current_card
    @last_try = (params[:last_try] == "true")
    @cards_next_round = params[:remaining_cards].to_i - 1
    return erb :game
  end 
  redirect "/game_over/#{@round.id}"
end

get '/game_over/:round_id' do
  @round = Round.find(params[:round_id])
  erb :game_over
end

post '/guess' do  
  @round = Round.find(params[:round_id])
  @round.guess(params[:answer], session[:current_card_id])
  redirect "/game/#{@round.id}/#{@round.last_try}/#{params[:remaining_cards]}"
end