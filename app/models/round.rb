class Round < ActiveRecord::Base
  attr_reader :current_card, :last_try
  attr_accessor :remaining_cards
  belongs_to :users
  belongs_to :decks
  has_many :guesses
  has_many :cards, :through => :decks

  def after_initialize
    
  end

  def prepare(n=-1)
    deck_cards = Deck.find(deck_id).cards
    if n == -1
      @remaining_cards = deck_cards
      @last_try = "true"
    else
      to_pop = (deck_cards.length - n.to_i)
      @remaining_cards= deck_cards
      @remaining_cards.pop(to_pop)
    end

  end
  
  def done?
    puts "+"*250
    puts @remaining_cards
    puts "+"*250
    @remaining_cards.count == 0
  end


  def next_card
    @current_card = @remaining_cards.pop
  end

  def guess(input, card_id)
    guess = Guess.create( guess: input, round_id: self.id, card_id: card_id)
    guess.check ? win_card : lose_card
  end

  def win_card
    self.num_correct += 1
    @last_try = true
  end

  def lose_card
    self.num_incorrect += 1
    @last_try = false
  end




end
