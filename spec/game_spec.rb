require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/card'
require_relative '../lib/hand'

RSpec.describe Game do
  describe '#initialize' do
    it 'creates new game with the given number of players' do
      num_players = 0
      game = Game.new(num_players)
      expect(game.players.length).to eq(num_players)
      expect(game.current_player).to eq(game.players.first)
      expect(game.pot).to eq(0)
      expect(game.current_bet).to eq(0)
    end
  end

  describe '#next_turn' do
    it 'moves turn to the next player' do
      game = Game.new(3)
      init_player = game.current_player
      game.next_turn
      expect(game.current_player).not_to eq(init_player)
    end
  end

  describe '#deal_initial_cards' do
    it 'deals 5 cards to each player' do
      game = Game.new(2)
      game.deal_initial_cards
      game.players.each do |player|
        expect(player.hand.cards.length).to eq(5)
      end
    end
  end

  describe '#collect_bets' do
    it 'collects bets from all players and updates both pot and bet' do
      game = Game.new(2)
      game.players[0].add_to_pot(1000)
      game.players[1].add_to_pot(500)
      game.collect_bets
      expect(game.pot).to eq(500)
      expect(game.current_bet).to eq(500)
    end

    it 'returns false if no one places a bet' do
      game = Game.new(2)
      result = game.collect_bets
      expect(result).to be false
    end
  end

  describe '#raise_bet' do
    it 'allows player to raise bet and updates both pot and bet' do
      game = Game.new(2)
      game.players[0].add_to_pot(1000)
      player = game.players[0]
      raise_amount = 200
      result = game.raise_bet(player, raise_amount)
      expect(result).to be true
      expect(game.pot).to eq(200)
      expect(game.current_bet).to eq(200)
    end

    it 'returns false if the player pot is not enough' do
      game = Game.new(2)
      player = game.players[0]
      raise_amount = 200
      result = game.raise_bet(player, raise_amount)
      expect(result).to be false
    end
  end

  describe '#determine_winner' do
    it 'returns winning player when one active player left' do
      game = Game.new(2)
      game.players[0].fold
      winner = game.determine_winner
      expect(winner).to eq(game.players[1])
    end

    it 'returns nil if all players are folded' do
      game = Game.new(2)
      game.players.each(&:fold)
      winner = game.determine_winner
      expect(winner).to be_nil
    end

    it 'returns the player with the highest hand rank as winner' do
      game = Game.new(2)
      game.players[0].deal_hand([
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
                                ])
      game.players[1].deal_hand([
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
                                ])
      winner = game.determine_winner
      expect(winner).to eq(game.players[1])
    end

    it 'compares highest cards for hands of the same rank' do
      game = Game.new(2)
      game.players[0].deal_hand([
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
                                ])
      game.players[1].deal_hand([
        Card.new('Hearts', 'Queen'),
        Card.new('Spades', 'Ace'),
        Card.new('Diamonds', 'King'),
        Card.new('Clubs', 'Jack'),
        Card.new('Spades', '10')
                                ])
      winner = game.determine_winner
      expect(winner).to eq(game.players[0])
    end
  end
end
