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
    starting_deck = deck_cards
    if n == -1
      @remaining_cards = starting_deck
      @last_try = "true"
    else
      cards_to_pop = (starting_deck.length - n)
      @remaining_cards = starting_deck
      @current_card = starting_deck[n]
      @remaining_cards.pop(cards_to_pop)
      puts '*' * 400
      puts deck_length
      puts @remaining_cards.length
      @first_card = (@remaining_cards.length == deck_length)
      # puts '*' *200
      # puts @current_card.inspect
    end

  end

  def deck_length
    @deck_length = Deck.find(deck_id).cards.length
  end

  def deck_cards
    @deck ||= Deck.find(deck_id).cards
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
    self.save
    @last_try = true
  end

  def lose_card
    self.num_incorrect += 1
    self.save
    @last_try = false
  end




end
