class Round < ActiveRecord::Base

  attr_reader :current_card, :last_try, :first_card, :deck, :deck_length
  attr_accessor :remaining_cards
  belongs_to :users
  belongs_to :decks
  has_many :guesses
  has_many :cards, :through => :decks

  def after_initialize
    
  end

  def prepare(n=-1)
    n = n.to_i
    @remaining_cards = deck_cards
    if n == -1
      @last_try = "true"
    else
      cards_to_pop = (@deck.length - n)
      @current_card = @deck[n]
      @remaining_cards.pop(cards_to_pop)
      @first_card = (@remaining_cards.length == deck_length)
    end

  end

  def deck_length
    @deck_length = Deck.find(deck_id).cards.length
  end

  def deck_cards
    @deck ||= Deck.find(deck_id).cards
  end
  
  def done?
    @remaining_cards.count == 0
  end


  def update_current_card
    @current_card = @remaining_cards.pop
  end

  def guess(input, card_id)
    guess = Guess.create( guess: input, round_id: self.id, card_id: card_id)
    guess.check ? increment_correct : increment_incorrect
  end

  def increment_correct
    self.num_correct += 1
    self.save
    @last_try = true
  end

  def increment_incorrect
    self.num_incorrect += 1
    self.save
    @last_try = false
  end




end
