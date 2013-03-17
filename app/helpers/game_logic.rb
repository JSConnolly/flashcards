helpers do 
  def run_game(round)
    unless session[:remaining_cards] == 0                   # runs until deck is empty (all cards have been dealt)
      round.prepare(session[:remaining_cards])             # this is what iterates through the deck, card by card
      @last_card = round.current_card                      # needed to show previous card's question and answer
      @card = round.update_current_card                    # sets the current card to next card in deck    
      session[:current_card_id] = round.current_card.id    # being used in post '/guess' to pass current card
      @last_try = (params[:last_try] == "true")             # @last_try used to show correct or incorrect in game.erb
      session[:remaining_cards] = round.remaining_cards.length
      return erb :game
    end 
    redirect "/game_over/#{round.id}"
  end
end