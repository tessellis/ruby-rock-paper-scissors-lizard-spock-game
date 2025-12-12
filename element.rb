# Author: Tess Ellis
# OSU Email: elliste@oreongstate.edu
# Lab: 3 - Ruby
# Class: Element - Abrstract superclass to 5 subclasses for each type of move. Returns result of one
#                  round, two strings describing move and tie, win, or lose

# <--- Abstract Superclass -->
class Element
    # using attribute accessors to create getter and setter functionality
    attr_accessor :name

    # initializing name variable
    def initialize(name)
        @name = name
      end

    # undefined (abstract) method
    def compare_to(other)
        fail "This method should be overridden"
    end
end

# <-- Rock subclass -->
class Rock < Element; end

# <-- Paper subclass -->
class Paper < Element; end

# <-- Scissors subclass -->
class Scissors < Element; end

# <-- Lizard subclass -->
class Lizard < Element; end

# <-- Lizard subclass -->
class Spock < Element; end

# <-- New instances of each move type -->
ROCK = Rock.new('Rock')
PAPER = Paper.new('Paper')
SCISSORS = Scissors.new('Scissors')
LIZARD = Lizard.new('Lizard')
SPOCK = Spock.new('Spock')

# <-- Global list to hold move types-->
MOVES = [ROCK, PAPER, SCISSORS, LIZARD, SPOCK]

# <-- Possible results for each type of move combination --> 
RESULTS = {
    # rock beats scissors and lizard
    'Rock'     => { 'Scissors' => 'Rock crushes Scissors',  'Lizard'   => 'Rock crushes Lizard' },
    # paper beats rock and spock
    'Paper'    => { 'Rock'     => 'Paper covers Rock',      'Spock'    => 'Paper disproves Spock' },
    # scissors beats paper and lizard
    'Scissors' => { 'Paper'    => 'Scissors cut Paper',     'Lizard'   => 'Scissors decapitate Lizard' },
    # lizard beats spock and paper
    'Lizard'   => { 'Spock'    => 'Lizard poisons Spock',   'Paper'    => 'Lizard eats Paper' },
    # spock beats scissors and rock
    'Spock'    => { 'Scissors' => 'Spock smashes Scissors', 'Rock'     => 'Spock vaporizes Rock' }
}

# <-- Comapare_to function for move comparison -->
[Rock, Paper, Scissors, Lizard, Spock].each do |klass|
    klass.class_eval do
      def compare_to(other)
        # if same move
        if name == other.name
          ["#{name} equals #{other.name}", 'Tie']
        # winning move
        elsif RESULTS[name].key?(other.name)
          [RESULTS[name][other.name], 'Win']
        # losing move
        else
          [RESULTS[other.name][name], 'Lose']
        end
      end
    end
  end