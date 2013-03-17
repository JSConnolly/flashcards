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
  if session[:user_id] 
    @user = User.find(session[:user_id])
    erb :profile
  else
    redirect '/login'
  end
end
