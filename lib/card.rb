class Card
  attr_reader :suit, :value

  # local card values variable will use later
  CARD_VALS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end
