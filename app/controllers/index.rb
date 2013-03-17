### INDEX

get '/' do
  # Look in app/views/index.erb
  erb :index
end

### USERS

get '/signup' do

  erb :signup
end

post '/signup' do
  @user = User.new( :name => params[:user][:name], :email => params[:user][:email])
  @user.password =  params[:user][:password]

  unless @user.save
    # errors
    puts params[:user]
    p params[:user][:password]
    puts @user.password
  end
  authenticate(@user.email, params[:user][:password])
  redirect "/profile/#{@user.id}"
end

get '/login' do
  erb :login
end


post '/login' do
  authenticate(params[:email], params[:password])
  @id = User.find_by_email(params[:email]).id
  redirect '/profile/' + @id.to_s
end

get '/logout' do
  session.clear
  redirect '/'
end


get '/profile/:id' do
  @user = User.find(params[:id])
  if current_user == @user
    @user
    erb :profile
  else
    redirect '/login'
  end
end


post '/game' do
Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    @round.prepare
    redirect "/game/#{@round.id}/#{@round.last_try}/#{@round.remaining_cards.length}"
end



### GAME


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
  puts '*' * 20
  puts params[:remaining_cards]
  puts params[:round_id]
  redirect "/game/#{@round.id}/#{@round.last_try}/#{params[:remaining_cards]}"
end



