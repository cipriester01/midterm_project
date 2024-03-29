require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :deck, :players, :current_player, :pot, :current_bet

  # creates a new game with number of players
  def initialize(num_players)
    @deck = Deck.new
    # stores player
    @players = []
    num_players.times { @players << Player.new }
    @current_player = @players.first
    # init pot and bet to nothing
    @pot = 0
    @current_bet = 0
  end

  # moves game to next player's turn
  def next_turn
    # prints player #
    index = @players.index(@current_player)
    # changes to next player
    @current_player = @players[(index + 1) % @players.length]
  end

  # gives each player 5 cards
  def deal_initial_cards
    @players.each { |player| player.deal_hand(@deck.deal(5)) }
  end

  # gets bets from players
  def collect_bets
    @current_bet = 0
    # loops each player for bet amount
    @players.each do |player|
    in_pot = player.see(@current_bet)
      @pot += in_pot
      @current_bet = in_pot if in_pot > @current_bet
    end
    # if all players bet nothing
    if @current_bet == 0
      puts "No player placed a bet, gg."
      return false
    end
    puts "Bet: #{@current_bet}"
    true
  end

  # raises and updates for player
  def raise_bet(player, amount)
    if player.raise_bet(amount)
      @current_bet = amount
      @pot += amount
      return true
    else
      return false
    end
  end

  # gets array of active players and returns
  def determine_winner
    active_players = @players.reject(&:folded)
    # if no one bets (ends loop)
    if active_players.empty?
      return nil
    elsif active_players.length == 1
      return active_players[0]
    else
      # sets winner to be first player then iterates through remaining active players
      winning_player = active_players[0]
      active_players.each do |player|
        # compares active player's hands
        if player.hand.rank != winning_player.hand.rank
          winning_player = player if Hand::HAND_RANKINGS[player.hand.rank] > Hand::HAND_RANKINGS[winning_player.hand.rank]
        else
          # compares highest cards and updates winner
          winning_player_cards = highest_card(winning_player.hand)
          player_cards = highest_card(player.hand)
          winning_player = player if player_cards > winning_player_cards
        end
      end
      return winning_player
    end
  end

  private

  # determines highest card
  def highest_card(hand)
    # sorts in decending order
    values = hand.cards.map { |card| Card::VALUES.index(card.value) }
    values.sort.reverse
  end
end
