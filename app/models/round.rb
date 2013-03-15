class Round < ActiveRecord::Base
  belongs_to :users
  belongs_to :decks
  has_many :guesses
  has_many :cards, through :decks
end
