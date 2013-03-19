post '/game' do                                          # called from profile.erb
Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    @round.prepare
    session[:round_id] = @round.id
    session[:remaining_cards] = @round.remaining_cards.length
    redirect "/game"
end

get '/game' do 
  @round = Round.find(session[:round_id])
  run_game(@round)  # find me in helpers under game_logic.rb               
end

get '/game_over' do
  @round = Round.find(session[:round_id])
  erb :game_over
end

post '/guess' do  
  content_type :json
  round = Round.find(session[:round_id])
  round.guess(params[:answer], session[:current_card_id])
  card = Card.find(session[:current_card_id]) 
  { last_try: round.last_try, answer: card.answer, question: card.question }.to_json
end

get '/next_card' do
  redirect "/game"
end