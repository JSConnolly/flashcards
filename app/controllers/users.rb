get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  unless @user.save
    # errors
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
