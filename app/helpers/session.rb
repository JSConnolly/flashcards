helpers do 
  def authenticate(email, password)
      @user = User.find_by_email(email)
      if @user.password == password
        give_token(@user)
        session_user_id(@user)
      else
        redirect '/'
      end
  end

  def give_token(user)
    @token = Token.create( user_id: user.id, value: SecureRandom.hex(10) )
    session[:token] = @token.value
  end

  def session_user_id(user)
    session[:user_id] = user.id
  end

  def current_user
    # validate existence of user with the token
    @current_user ||= User.find( Token.find_by_value(session[:token]).user_id )
  end



end

