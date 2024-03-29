require_relative '../lib/deck'

RSpec.describe Deck do
  describe '#initialize' do
    it 'creates deck of 52 cards' do
      deck = Deck.new
      expect(deck.cards.length).to eq(52)
    end
  end

  # necessary to produce 52 unique cards
  describe '#build_deck' do
    it 'builds a 52-card deck together' do
      deck = Deck.new
      suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
      values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
      expected_cards = suits.product(values).map { |suit, value| Card.new(suit, value) }
      expect(deck.cards).to match_array(expected_cards)
    end
  end

  describe '#shuffle!' do
    it 'shuffles the deck of 52' do
      deck = Deck.new
      # didnt know how dup worked, so it may not work correctly
      og_order = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).not_to eq(og_order)
    end
  end

  describe '#deal' do
    it 'deals that number of cards from your deck' do
      deck = Deck.new
      cards = deck.deal(5)
      expect(cards.length).to eq(5)
      expect(deck.cards.length).to eq(47)
    end
  end
end
