require_relative '../lib/hand'
require_relative '../lib/card'

RSpec.describe Hand do
  describe '#initialize' do
    it 'builds new hand with the given cards' do
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      hand = Hand.new(cards)
      expect(hand.cards).to eq(cards)
    end
  end

  # simple quality of life
  describe '#to_s' do
    it 'returns a string representation of player hand' do
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      hand = Hand.new(cards)
      expected_str = 'Queen of Hearts, Ace of Spades, King of Diamonds, Jack of Clubs, 10 of Spades'
      expect(hand.to_s).to eq(expected_str)
    end
  end

  describe '#rank' do
    it 'correctly recognizes a royal flush hand' do
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      hand = Hand.new(cards)
      expect(hand.rank).to eq('Royal Flush')
    end

    it 'correctly recognizes a straight flush hand' do
      cards = [
        Card.new('Spades', '9'),
        Card.new('Spades', '8'),
        Card.new('Spades', '7'),
        Card.new('Spades', '6'),
        Card.new('Spades', '5')
      ]
      hand = Hand.new(cards)
      expect(hand.rank).to eq('Straight Flush')
    end

    it 'correctly recognizes when player has four of a kind' do
      cards = [
        Card.new('Hearts', 'Ace'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'Ace'),
        Card.new('Clubs', 'Ace'),
        Card.new('Diamonds', '10')
      ]
      hand = Hand.new(cards)
      expect(hand.rank).to eq('Four of a Kind')
    end
  end
end
