require_relative 'card'

class Deck
  attr_reader :cards

  # inits new deck of cards in array and shuffles
  def intialize
    @cards = []
    build_deck
    shuffle!
  end

  # method that shuffles deck array
  def shuffle!
    @cards.shuffle!
  end

  # creates 52 card deck
  def build_deck
    # define suits + vals
    suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

    # loops to create cards
    suits.each do |suit|
      values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  # deals cards from deck, and removes number from front of deck
  def deal(num_cards)
    @cards.shift(num_cards)
  end
end
