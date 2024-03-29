require_relative 'game'
require_relative 'player'
require_relative 'card'
require_relative 'hand'
require_relative 'deck'

# starts game
puts "Want to play Five Card Draw Poker?"
print "How many players? "
num_players = gets.chomp.to_i
game = Game.new(num_players)

game.deal_initial_cards

loop do

  # first round
  puts "\nBetting Round"
  if game.collect_bets
    puts "No bets placed, gg."

    next
  end

  game.players.each do |player|
    next if player.folded
    puts "\n#{player.hand}"

    print "#{player.hand.rank} - Enter what cards to discard(1 2 3 4 5): "
    discarded_cards = gets.chomp.split.map { |index| player.hand.cards[index.to_i - 1] }
    player.discard(discarded_cards)
    # gives player cards based on discarded and prints
    new_cards = game.deck.deal(discarded_cards.length)
    player.deal_hand(player.hand.cards + new_cards)
    puts "Your new hand: #{player.hand}"
  end

  # second round
  puts "\nBetting Round"
  game.players.each do |player|
    next if player.folded
    print "Player #{game.players.index(player) + 1}, you have $#{player.pot}. Would you like to Fold, See, or Raise (F, S, R)? "
    response = gets.chomp.upcase
    case response
    when 'F'
      player.fold
      puts "Player #{game.players.index(player) + 1} folded."
    when 'S'
      player.see(game.current_bet)
      game.pot += game.current_bet
      puts "Player #{game.players.index(player) + 1}, the bet is $#{game.current_bet}."
    when 'R'
      print "What do you raise? "
      raise_amount = gets.chomp.to_i
      if game.raise_bet(player, raise_amount)
        puts "Player #{game.players.index(player) + 1} has raised the bet to $#{raise_amount}."
      else
        puts "Player #{game.players.index(player) + 1} is BROKE HAHA laugh at them now."
      end
    else
      puts "ERROR: invalid response, please re-do."
      redo
    end
  end

  # determines winner
  winner = game.determine_winner
  if winner.nil?
    puts "All players folded, gg to all."
  else
    puts "\nThe winner is (DRUMROLL) Player #{game.players.index(winner) + 1} with #{winner.hand.rank}: #{winner.hand}!!"
    puts "Pot Amount: $#{game.pot}"
    winner.add_to_pot(game.pot)
    puts "Player #{game.players.index(winner) + 1}'s new pot is $#{winner.pot}! Wow."
  end

  # prompts replay question
  print "\nWould you like to play again? (y/n): "
  play_again = gets.chomp.upcase
  break if play_again != 'y'

  # resets every player to folded false for new round and empties deck (expected in tests)
  game.players.each(&:reset_folded)
  game.deck = Deck.new
end
