get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/login'
  @user = login(params[:login])
  if @user  
    redirect to '/user/' + @user.id
  else
    # throw error
  end
end



get '/user/:id' do
  params[:id]
  erb :profile
end


get '/user/:id/:deck' do
  
  # play()
  #   until the game is over, play
  #   when done
  #     erb :success
  #   end
  
  erb :game

end









get '/signup' do
  
  erb :signup

end

post 'user/new' do

  erb :profile
end
