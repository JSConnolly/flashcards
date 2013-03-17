post '/game' do  # called from profile.erb. Starts game by passing in deck user chooses from dropdown
Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    @round.prepare
    session[:remaining_cards] = @round.remaining_cards.length
    redirect "/game/#{@round.id}/#{@round.last_try}"
end

get '/game/:round/:last_try' do 
  @round = Round.find(params[:round])                     # sets @round variable to current round
  unless session[:remaining_cards] == 0                 # runs until deck is empty (all cards have been dealt)
    @round.prepare(session[:remaining_cards])              # this is what iterates through the deck, card by card
    @last_card = @round.current_card                      # needed to show previous card's question and answer
    @card = @round.update_current_card                    # sets the current card to next card in deck    
    session[:current_card_id] = @round.current_card.id    # being used in post '/guess' to pass current card
    @last_try = (params[:last_try] == "true")             # @last_try used to show correct or incorrect in game.erb
    session[:remaining_cards] = @round.remaining_cards.length
    return erb :game
  end 
  redirect "/game_over/#{@round.id}"                # runs once deck is empty
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