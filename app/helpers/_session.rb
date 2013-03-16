helpers do 
  def authenticate(email, password)
      @user = User.find_by_email(email)
      puts password
      if password == password
        give_token(@user)
      else
        redirect '/'
      end
  end


  def give_token(user)
    #refactor to actually use a token
    session[:email] = user.email
  end

  def current_user
    # validate existence of user with the token
    @current_user ||= User.find_by_email( session[:email] )
  end



end

