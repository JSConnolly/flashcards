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
    session[:email] = user.email
  end

end

