require_relative '../lib/player'
require_relative '../lib/card'
require_relative '../lib/hand'

RSpec.describe Player do
  describe '#initialize' do
    it 'creates a new player with an empty hand and default pot' do
      player = Player.new
      expect(player.hand.cards).to be_empty
      expect(player.pot).to eq(0)
      expect(player.folded).to be false
    end

    it 'creates a new player with an initial hand and pot' do
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      hand = Hand.new(cards)
      player = Player.new(1000, hand)
      expect(player.hand).to eq(hand)
      expect(player.pot).to eq(1000)
      expect(player.folded).to be false
    end
  end

  describe '#deal_hand' do
    it 'deals player a hand of 5 cards' do
      player = Player.new
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      player.deal_hand(cards)
      expect(player.hand.cards).to eq(cards)
    end
  end

  describe '#discard' do
    it 'discards cards from player hand' do
      player = Player.new
      cards = [
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
      ]
      player.deal_hand(cards)
      cards_to_discard = [cards[0], cards[2]]
      player.discard(cards_to_discard)
      # this formula wasnt working correctly and i'm not sure it is still
      expect(player.hand.cards).to eq([cards[1], cards[3], cards[4]])
    end
  end

  describe '#fold' do
    it 'marks the player as folded' do
      player = Player.new
      player.fold
      expect(player.folded).to be true
    end
  end

  describe '#see' do
    it 'pulls and displays the current pot bet to the player' do
      player = Player.new(10000)
      current_bet = 200
      amount_seen = player.see(current_bet)
      expect(amount_seen).to eq(200)
      expect(player.pot).to eq(9800)
    end

    it 'returns the remaining pot if current bet is larger' do
      player = Player.new(50)
      current_bet = 100
      amount_seen = player.see(current_bet)
      expect(amount_seen).to eq(50)
      expect(player.pot).to eq(0)
    end
  end

  describe '#raise_bet' do
    it 'takes raise from player pot and returns it' do
      player = Player.new(100)
      raise_amount = 20
      amount_raised = player.raise_bet(raise_amount)
      expect(amount_raised).to eq(20)
      expect(player.pot).to eq(80)
    end

    it 'raises an error if the player pot is not valid' do
      player = Player.new(50)
      raise_amount = 100
      expect { player.raise_bet(raise_amount) }.to raise_error('You are broke!')
    end
  end

  describe '#add_to_pot' do
    it 'adds pot amount to the player pot' do
      player = Player.new(450)
      amount_to_add = 800
      player.add_to_pot(amount_to_add)
      expect(player.pot).to eq(1250)
    end
  end

  describe '#reset_folded' do
    it 'resets players who are folded to false' do
      player = Player.new
      player.fold
      player.reset_folded
      expect(player.folded).to be false
    end
  end
end
