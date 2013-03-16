helpers do 

  def authenticate(email, password)
      @user = User.find_by_email(email)
      if @user.password == password
        give_token(@user)
      else
        redirect '/login'
      end
  end


  def give_token(user)
    @token = user.email = session[:email]
  end

end

