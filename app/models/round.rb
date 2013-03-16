class Round < ActiveRecord::Base
  attr_reader :remaining_cards, :current_card, :last_try

  belongs_to :users
  belongs_to :decks
  has_many :guesses
  has_many :cards, through :decks

  def initialize
    # @deck = Deck.find(deck_id)
    @remaining_cards = @deck.cards.shuffle
  end

  def done?
    @remaining_cards.length == 0
  end


  def next_card
    @current_card = @remaining_cards.pop
  end

  def guess(input)
    guess = Guess.create( guess: input, round_id: id, card_id: @current_card.id)
    guess.check(input) ? win_card : lose_card
  end

  def win_card
    num_correct += 1
    @last_try = true
  end

  def lose_card
    num_incorrect += 1
    @last_try = false
  end




end
