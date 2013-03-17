get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  unless @user.save
    # errors
  end
  authenticate(@user.email, params[:user][:password])
  redirect "/profile"
end

get '/login' do
  erb :login
end

post '/login' do
  authenticate(params[:email], params[:password])
  redirect '/profile'
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/profile' do
  @user = User.find(session[:id])
  if current_user() == @user
    @user
    erb :profile
  else
    redirect '/login'
  end
end
