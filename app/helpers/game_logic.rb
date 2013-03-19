helpers do 

  def run_game(round)
    unless session[:remaining_cards] == 0  # runs until deck is empty (all cards have been dealt)                 
      prepare_round(round) # method is below      
      @last_card = round.current_card # needed to show previous card's question and answer (see game.erb)
      @card = round.update_current_card # sets the current card to next card in deck
      set_current_card(round) # method is below
      update_remaining_cards(round) # method is below
      return erb :game # gets passed everything with an @ sign above (all the instance variables)
    end 
    redirect "/game_over"
  end

  def prepare_round(round)
    round.prepare(session[:remaining_cards]) # this is what iterates through the deck, card by card
  end

  def set_current_card(round)
    session[:current_card_id] = round.current_card.id  # being used in post '/guess' to pass current card
  end

  def update_remaining_cards(round)
    session[:remaining_cards] = round.remaining_cards.length 
  end

end