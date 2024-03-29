require_relative 'card'

class Deck
  attr_reader :cards

  def intialize
    @cards = []
    build_deck
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def build_deck
    suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

    suits.each do |suit|
      values.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def deal(num_cards)
    @cards.shift(num_cards)
  end
end
