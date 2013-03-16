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
  @user = User.new(params[:signup]) 
  unless @user.save
    # errors
  end
  erb :profile
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
  if @token == @user.email
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


get '/game' do
  params[:deck]
  @round = Round.create
  @round.deck << params[:deck]

  @deck = params[:deck]
  @card = @deck.cards.first

  erb :game

end

get '/user/id/deck/:card' do


  erb :game
end

post '/guess' do
  #logic about what to store/what card to show
end



