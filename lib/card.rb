class Card
  attr_reader :suit, :value

  # local card values array will use later (had to change var name i used it too much lol)
  card_array = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  # init and assign suit and value to obj
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  # returns string that has card details
  def to_s
    "#{@value} of #{@suit}"
  end
end
