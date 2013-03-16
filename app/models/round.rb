class Round < ActiveRecord::Base
  belongs_to :users
  belongs_to :decks
  has_many :guesses
  has_many :cards, through :decks

  def initialize
    @deck = Deck.find(deck_id)
    @deck.shuffle!
    @remaining_cards = @deck.cards
  end

  def next_card
    @current_card = @remaining_cards.pop
  end

  def guess(input)
    guess = Guess.create( guess: input, round_id: id, card_id: @current_card.id)
    guess.check ? win_card : lose_card
  end

  def win_card
    num_correct += 1
  end

  def lose_card
    num_incorrect += 1
  end




end
