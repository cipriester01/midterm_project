require_relative 'hand'

class Player
  attr_reader :hand, :pot, :folded
  # inits a new player
  def initialize(initial_pot = 0, initial_hand = nil)
    # ran into a lot of issues with the hand reading empty or nil, solved with below
    @hand = initial_hand || Hand.new([])
    @pot = initial_pot
    @folded = false
  end

  def deal_hand(cards)
    # creates a hand obj for new hand of cards
    @hand = Hand.new(cards)
  end

  # method for what cards a dropped
  def discard(cards_to_discard)
    cards_to_discard.each do |card|
      # removes from player hand
      @hand.cards.delete(card)
    end
  end

  # if player folds, changes to true
  def fold
    @folded = true
  end

  # calls bet
  def see(current_bet)
    # does player have enough?
    if @pot >= current_bet
      # take bet from player pot
      @pot -= current_bet
      return current_bet
    else
    in_pot = @pot
      @pot = 0
      # return remaining
      return in_pot
    end
  end

  # method for raising function in poker
  def raise_bet(amount)
    if @pot >= amount
      @pot -= amount
      return amount
    else
      # if player is broke
      raise "Not enough money to raise bet."
    end
  end

  # adds to player pot
  def add_to_pot(amount)
    @pot += amount
  end

  # resets status to not-folded for end of round (YOU NEED THIS)
  def reset_folded
    # dont delete
    @folded = false
  end
end
