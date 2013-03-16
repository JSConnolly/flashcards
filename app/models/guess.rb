class Guess < ActiveRecord::Base
  belongs_to :card
  belongs_to :round
  before_save :check_guess

  def check
    if guess.strip.downcase == Card.find(card_id).answer.strip.downcase
      correct = 'true'
      return true
    else 
      correct = 'false'
      return false
    end
  end
end
