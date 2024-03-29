require_relative 'card'

class Hand
  attr_reader :cards

  # maps hand ranks to numerical values for easy use
  HAND_RANKINGS = {
    'High Card' => 0,
    'One Pair' => 1,
    'Two Pair' => 2,
    'Three of a Kind' => 3,
    'Straight' => 4,
    'Flush' => 5,
    'Full House' => 6,
    'Four of a Kind' => 7,
    'Straight Flush' => 8,
    'Royal Flush' => 9
  }

  def initialize(cards)
    @cards = cards
  end

  # returns string of hand
  def to_s
    # parse string with ,
    @cards.map(&:to_s).join(', ')
  end

  # ranking of hands (decending)
  def rank
    if royal_flush?
      return 'Royal Flush'
    elsif straight_flush?
      return 'Straight Flush'
    elsif four_of_a_kind?
      return 'Four of a Kind'
    elsif full_house?
      return 'Full House'
    elsif flush?
      return 'Flush'
    elsif straight?
      return 'Straight'
    elsif three_of_a_kind?
      return 'Three of a Kind'
    elsif two_pair?
      return 'Two Pair'
    elsif one_pair?
      return 'One Pair'
    else
      return 'High Card'
    end
  end

  private

  # math for hand criteria/rankings
  def royal_flush?
    straight_flush? && @cards.map(&:value).sort == ['10', 'Jack', 'Queen', 'King', 'Ace']
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    card_values = @cards.map(&:value)
    card_values.any? { |value| card_values.count(value) == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    @cards.map(&:suit).uniq.length == 1
  end

  def straight?
    values = @cards.map(&:value).sort_by { |value| Card::VALUES.index(value) }
    (0..3).all? { |i| Card::VALUES.index(values[i + 1]) - Card::VALUES.index(values[i]) == 1 }
  end

  def three_of_a_kind?
    card_values = @cards.map(&:value)
    card_values.any? { |value| card_values.count(value) == 3 }
  end

  def two_pair?
    card_values = @cards.map(&:value)
    card_values.select { |value| card_values.count(value) == 2 }.uniq.length == 2
  end

  def one_pair?
    card_values = @cards.map(&:value)
    card_values.any? { |value| card_values.count(value) == 2 }
  end
end
