# Author: Tess Ellis
# OSU Email: elliste@oreongstate.edu
# Lab: 3 - Ruby
# Class: History - Enables the logging of gameplay

# <-- History Class -->
class History
    # creating getter and setting functionality
    attr_accessor :plays, :opponent_plays, :score

    # initializing empty arrays and score to zero
    def initialize
        # empty plays array
        @plays = []
        # empty oponnent plays array
        @opponent_plays = []
        # initializing score to zero
        @score = 0
    end

    # logging play/move
    def log_play(move) = @plays << move
    # loggin oponnent play/move
    def log_opponent_play(move) = @opponent_plays << move
    # icrementing score
    def add_score = @score += 1
end


