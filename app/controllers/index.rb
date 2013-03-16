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

get '/profile/:id' do
  @user = User.find(params[:id])
  if current_user == @user
    @user
    erb :profile
  else
    redirect '/login'
  end
end



get '/logout' do
  session.clear
  redirect '/'
end




### GAME


get '/game/:round' do
  unless @round.done?
    @round.next_card
    @card = @round.current_card
    @last_try = @round.last_try
    # @data = [@last_try, @card]
    return erb :game
  end

  @done= @round.done
  erb :game
end

post '/game' do
  if Deck.find(params[:deck])
    @round = Round.create( :user_id => current_user.id, :deck_id => params[:deck] )
    redirect '/game/#{@round.id}'
  end
end

get '/user/id/deck/:card' do

  erb :game
end

post '/guess' do
  @round = Round.find(params)
  @round.guess(params[:answer])
  redirect "/game/#{@round.id}"
end



