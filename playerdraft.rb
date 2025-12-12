# Author: Tess Ellis
# OSU Email: elliste@oreongstate.edu
# Lab: 3 - Ruby
# Class: History - Enables the logging of gameplay

require_relative "element"
require_relative "history"

class Player
    # using attribute accessors to create getter and setter functionality
    # removing :name since we never actually use it?
    attr_reader :name, :history

    def initialize(name)
        @name = name
        @history = History.new
    end

    # undefined (abstract) method
    def play(_opponent_move = nil)
        fail "This method should be overridden"
    end
end

# always chooses rock
class StupidBot < Player
    def play(_opponent_move = nil)
        Rock.new
    end
end

# randomly chooses 1 of the 5 moves
class RandomBot < Player
    def play(_opponent_move = nil)
        [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new].sample
    end
end

# chooses each move in order, from rock to spock
class IterativeBot < Player
    def initialize(name)
        super(name)
        @index = 0
        @moves = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]
    end

    def play(_opponent_move = nil)
        move = @moves[@index % @moves.size]
        @index += 1
        move
    end
end

# chooses the opponent's last move, begins with rock
class LastPlayBot < Player
    def initialize(name)
        super(name)
        @last_opponent_move = Rock.new
    end

    def play(opponent_move = nil)
        @last_opponent_move = opponent_move unless opponent_move.nil?
        @last_opponent_move
    end
end

# allows for human player input - manual input selection 
class Human < Player
    def play(_opponent_move = nil)
        puts "Choose your move:"
        puts puts "Choose your move:"
        puts "(1) Rock"
        puts "(2) Paper"
        puts "(3) Scissors"
        puts "(4) Lizard"
        puts "(5) Spock"
        print "> "
        option = gets.chomp.to_i

        case option
        when 1 then Rock.new
        when 2 then Paper.new 
        when 3 then Scissors.new 
        when 4 then Lizard.new 
        when 5 then Spock.new
        else 
            Rock.new
        end
    end
end
