# ruby-rock-paper-scissors-lizard-spock-game
A Ruby program that simulates a five-gesture expansion of the classic game rock-paper-scissors using OO paradigms (Object-Oriented)

# Program Description
## Element Class
First, create a file ```element.rb``` in which you create a class named ```Element```. This class will serve as an abstract superclass to five subclasses: ```Rock```, ```Paper```, ```Scissors```, ```Lizard```, ```Spock```.

The ```Element``` class has one instance variable name, which will store the ```name``` of the ```Element``` (e.g., "Rock", "Lizard", etc.). In Ruby we use attribute accessors to create getter and setter functionality. Add the following as the first line of your class.

``` attr_accessor :name```
This line defines the instance variable ```@name```. This permits getting the value ```name``` and setting the value ```name=...```

The constructor (```initialize```) takes ```name``` as a parameter and saves it to the instance variable ```@name```. 

Lastly, create a method ```compare_to``` that takes an instance of the class ```Element``` as an argument. In the superclass ```Element```, leave this method undefined (abstract), using the line ```fail "This method should be overridden"``` to throw an exception. You will instantiate the method in the five concrete subclasses.

As the next step, create your five subclasses: ```Rock```, ```Paper```, ```Scissors```, ```Lizard```, ```Spock```. For each you should only need to implement (override) the ```compare_to method```. Ruby allows multiple return types. Your compare_to method will compare the argument against its own name and determine the outcome, returning two strings.

The first return value is a string describing one of the following outcomes:

* Scissors cut Paper
* Paper covers Rock
* Rock crushes Lizard
* Lizard poisons Spock
* Spock smashes Scissors
* Scissors decapitate Lizard
* Lizard eats Paper
* Paper disproves Spock
* Spock vaporizes Rock
* Rock crushes Scissors
For a tie, you should output a string such as ```Rock equals Rock```.

The second return value will return one of the following round outcomes:
* Win
* Lose
* Tie

Now create one concrete instance of each of the five Elements (using ```new```) and store these in a global list (outside the ```Element``` class, but inside the ```element.rb``` file) named ```moves```. Throughout the lab, your will reuse these instances of the moves, rather than creating new instances as needed.

## Self-Check
You can now test your  ```Element classes```. For example, the code:
```
rock  = Rock.new('Rock')
paper = Paper.new('Paper')
puts rock.compare_to(paper)
puts paper.compare_to(rock)
puts rock.compare_to(rock)
```
should yield output similar to this (the result string may be on another line):
```
Paper covers Rock, Lose
Paper covers Rock, Win
Rock equals Rock, Tie
```
## History Class
In the file ```history.rb``` you will create a class ```History``` that enables the logging of gameplay. Each individual ```Player``` will store its own history and differentiates between a play it made and a play that its opponent made. 

This class will serve as a simple data structure, storing an array of ```@plays```, and array of ```@opponent_plays```, and a single numeric ```@score```. Define these instance variables using ```attr_accessor``` for each of three instance variables.

In the constructor, initialize ```score``` to zero. Initialize both arrays to an empty array using ```Array.new```. This class will contain three simple methods that enable logging of gameplay details.

* ```log_play(move)```
* ```log_opponent_play(move)```
* ```add_score()```
The first two methods ```push``` the ```move``` to the ```@plays``` and ```@opponent_plays``` arrays, respectively. The ```add_score``` method simply increments ```@score``` by one each time it is called. Please note, you should only log opponent moves after both players have selected a move.

## Player Class
Next, you will create a series of classes for the Players in the file ```player.rb```. Begin with an abstract superclass named ```Player```. This class will need to know about classes ```Element and History```.
```
require_relative "element"
require_relative "history"
```
This class has two instance variables: ```name``` and ```history```. ```@name``` is a string naming the Player. ```@history``` is an object representing the play history for this player. Add the following line at the start of class ```Player```, which declares the instance variables and creates a reader (getter) for both. We do not need a setter so we use ```attr_reader``` instead of ```attr_accessor```.
```
attr_reader :name, :history
```
Add a constructor that takes ```name``` and ```history``` and sets the instance variables ```@name``` and ```@history``` respectively. Next, create a method ```play()```. In the superclass ```Player```, leave this method undefined, using the line ```fail "This method should be overridden"``` to throw an exception. You will instantiate the method in the concrete subclasses.

Now you are ready to create the concrete ```Player``` subclasses. When implementing the ```play``` method for each player below, make sure to log the move to the ```@history``` object. 

### Stupid Bot
Begin with a class named ```StupidBot```. For this class, define the ```play()``` method to return the same move every time. Because ```StupidBot``` is dumber than a box of rocks, have it play ```Rock``` each and every time.

### Random Bot
Next, create the class ```RandomBot```. This player will randomly pick and return one of the five possible moves from your moves list.

### Iterative Bot
Your next Player, ```IterativeBot```, begins with one move and cycles through all the moves, one by one in order, repeating the sequence only after having played all five moves (in this order: Rock, Paper, Scissors, Lizard, Spock).

### LastPlay Bot
Player ```LastPlayBot``` will always play the move that the opponent played on the previous move. For the first move, since there was no previous move to reference, return ```Rock```.

### Human Player
Lastly, you will define a ```Human``` player class. This player will ask the user to determine the move. For each turn, the ```play()``` method will print the options and request input from the user, as illustrated in the example below. Be sure to only accept valid moves from the user.
```
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 6
Invalid move - try again
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 2
```
In order to match the automated tests, you must type the above options exactly! It is recommended you copy and paste the above strings, one by one, as you create lines to puts the options for the human player menu.  

### Self-Check
You can now test your ```Player``` classes. For example, the code:
```
p1 = StupidBot.new('StupidBot', History.new)
p2 = RandomBot.new('RandomBot', History.new)
p1move = p1.play()
p2move = p2.play()
puts p1move.compare_to(p2move)
```
might yield the output similar to the following
```
Rock crushes Scissors, Win
```
## Main File
You will define the main class that will simulate a game of Rock-Paper-Scissors-Lizard-Spock. Use the (mostly blank) file ```lab3.rb``` provided in the starter pack. This file does not need to contain a class definition, although you are welcome to implement it that way. 

Your game will play five rounds between two players, determining the winner (or a draw) at the conclusion of the game. A sample game output is shown below.

You have the freedom to organize this file as you determine appropriate. Use good practices of functional abstraction and write reusable methods that perform a simple task. 

Begin with a welcome message. Next, have the user select Player1 and Player2 from a list (see example below). Again ensure that the user can only make valid selections of one of your five Players or start over and select Player 1 and Player 2 again.

Since all the Players implement the ```play``` method, the actual Player class instantiated will not be determined until runtime.

Now, using a loop structure, play five rounds of Rock-Paper-Scissors-Lizard-Spock. For each player, print out the move selected. Also print out the result description (e.g., ```Rock crushes Scissors```) and determine the round winner. Your output should resemble the example output shown below. You should be keeping score so that you can determine the game-winner after the five rounds. Print out the game-winner.

## Example Gameplay
This is an example showing a complete game of RPSLS. In this example, the user input is shown in bold. This playthrough shows the use of invalid input and how to handle it. Study this example! Your text output must match the expected test output exactly to receive credit for the test. 
```
Welcome to Rock, Paper, Scissors, Lizard, Spock!

Please choose two players:
(1) StupidBot
(2) RandomBot
(3) IterativeBot
(4) LastPlayBot
(5) Human
Select player 1: 0
Select player 2: 7
Invalid choice(s) - start over

Select player 1: 5
Select player 2: 3
Human vs. IterativeBot

Round 1:
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 55
Invalid move - try again
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 5
Player 1 chose Spock
Player 2 chose Rock
Spock vaporizes Rock
Player 1 won the round

Round 2:
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 4
Player 1 chose Lizard
Player 2 chose Paper
Lizard eats Paper
Player 1 won the round

Round 3:
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 3
Player 1 chose Scissors
Player 2 chose Scissors
Scissors equals Scissors
Round was a tie

Round 4:
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 2
Player 1 chose Paper
Player 2 chose Lizard
Lizard eats Paper
Player 2 won the round

Round 5:
(1) Rock
(2) Paper
(3) Scissors
(4) Lizard
(5) Spock
Enter your move: 1
Player 1 chose Rock
Player 2 chose Spock
Spock vaporizes Rock
Player 2 won the round

Final score is 2 to 2
Game was a draw
```
