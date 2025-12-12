# Lab: 3 - Ruby
# Main - Defines game play (5 rounds per game)

require_relative "element"   
require_relative "player"   
require_relative "history" 

######################################### 	
#     CS 381 - Programming Lab #3		#
#										#
#  < Tess Ellis >					 	#
#  < elliste@oregonstate.edu>	        #
#										#
#########################################

# <-- make_player function as per instruc -->
def make_player(option, label)
	# creating new history instance
	hist = History.new
	case option
	# creating new element instances (.new) for each
	when 1 then StupidBot.new(label, hist)
	when 2 then RandomBot.new(label, hist)
	when 3 then IterativeBot.new(label, hist)
	when 4 then LastPlayBot.new(label, hist)
	else Human.new(label, hist)
	end
end

# <-- allows human user to choose player type option through input -->
def player_choice
	puts "Please choose two players:"
	puts "(1) StupidBot"
	puts "(2) RandomBot"
 	puts "(3) IterativeBot"
	puts "(4) LastPlayBot"
	puts "(5) Human"

	player1 = player2 = nil
	loop do
		print 'Select player 1: '
		# converting and stripping input
		player1 = STDIN.gets&.strip.to_i
		print 'Select player 2: '
		# converting and stripping input
		player2 = STDIN.gets&.strip.to_i
		# breaking if invalid choice (not in 1 through 5)
		break if (1..5).include?(player1) && (1..5).include?(player2)
		puts 'Invalid choice(s) - start over'
	end
	[player1, player2]
end

# <-- Game structure, with 5 rounds as per instruct --> 
def game(rounds = 5)
	# initial welcome
	puts 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
	# blank line
	puts
  
	# setting player naming/option
	p1_option, p2_option = player_choice
	p1 = make_player(p1_option, 'Player 1')
	p2 = make_player(p2_option, 'Player 2')
  
	# printing player type vs player type
	puts "#{p1.class} vs. #{p2.class}"
	puts
  
	# initializing loop
	rounds.times do |i|
		# print round number
		puts "Round #{i + 1}:"

		# setting first move using play func form player
		first_move = p1.play
		# setting second
		second_move = p2.play
	
		# logging after second play
		p1.history.log_opponent_play(second_move)
		# logging
		p2.history.log_opponent_play(first_move)
	
		# priting moves as per instruct
		puts "Player 1 chose #{first_move.name}"
		puts "Player 2 chose #{second_move.name}"
	
		# comparing first and second move
		desc, result = first_move.compare_to(second_move)
		puts desc
	
		case result
		# printing winner and loser for round
		when 'Win'
			puts 'Player 1 won the round'
			p1.history.add_score
		when 'Lose'
			puts 'Player 2 won the round'
			p2.history.add_score
		else
		# tie message as per instruct
			puts 'Round was a tie'
		end
		puts
	end
	# purtting final score messages
	puts "Final score is #{p1.history.score} to #{p2.history.score}"
	if p1.history.score > p2.history.score
		puts 'Player 1 wins'
	elsif p2.history.score > p1.history.score
		puts 'Player 2 wins'
	else
		puts 'Game was a draw'
  	end
end

# kicking off with game func
game