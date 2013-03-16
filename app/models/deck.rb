class Deck < ActiveRecord::Base
  has_many :cards
  has_many :rounds
  
  @deck = cards

  def shuffle!
    @deck.shuffle!
  end

end
