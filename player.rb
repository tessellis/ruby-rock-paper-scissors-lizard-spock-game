# Author: Tess Ellis
# OSU Email: elliste@oreongstate.edu
# Lab: 3 - Ruby
# Class: Player - Sets player options for automated or input-based play

require_relative 'element'
require_relative 'history'

class Player
    # using attribute accessors to create getter and setter functionality
    attr_reader :name, :history

    def initialize(name, history)
        @name = name
        @history = history
    end

    # undefined (abstract) method
    def play
        fail "This method should be overridden"
    end
end

# always chooses rock
class StupidBot < Player
    def play
        move = ROCK
        # logging move in history
        history.log_play(move)
        move
    end
end

# randomly chooses 1 of the 5 moves
class RandomBot < Player
    def play
        # randoml sampling
        move = MOVES.sample
        # logging move
        history.log_play(move)
        move
    end
end

# chooses each move in order, from rock to spock
class IterativeBot < Player
    def initialize(name, history)
        super
        @index = 0
    end

    def play
        move = MOVES[@index]
        #irerating through length of moves
        @index = (@index + 1) % MOVES.length
        # logging move
        history.log_play(move)
        move
    end
end

# chooses the opponent's last move
class LastPlayBot < Player
    def play
        # playing opponent's last and defaulting to rock for first move
        move = history.opponent_plays.last || ROCK
        # logging move
        history.log_play(move)
        move
    end
end

# allows for human player input - manual input selection 
class Human < Player
    # human user choices
    PRINTER = <<~CHOICES
    (1) Rock
    (2) Paper
    (3) Scissors
    (4) Lizard
    (5) Spock
  CHOICES

  def play
    loop do
        puts PRINTER
        print 'Enter your move: '
        # reading move and removing leading or trailing whitespace
        choice = STDIN.gets&.strip
        # converting to int, storing in idx
        idx = choice.to_i
        # setting loop restrict
        if (1..5).include?(idx)
            # lining up to index num of move
            move = MOVES[idx - 1]
            # logging
            history.log_play(move)
            return move
        else
            puts 'Invalid move - try again'
        end
    end
  end
end
