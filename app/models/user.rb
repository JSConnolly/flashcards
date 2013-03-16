require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }
    #validate email uniqueness

  include BCrypt
  has_many :rounds
  has_many :decks, through :rounds
  has_many :guesses, through :rounds

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
