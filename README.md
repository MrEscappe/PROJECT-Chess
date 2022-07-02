# Chess
The goal of this project is making a complete [Chess](https://www.chess.com/learn-how-to-play-chess) game in ruby.

This is the final project in Ruby path from [The Odin Project](https://www.theodinproject.com/lessons/ruby-ruby-final-project)
## Demo
![demo gaming](https://cdn.discordapp.com/attachments/941796190964572213/992568153706090546/chess_demo.gif)
*a demo gaming.*
You can play it on rptl.

## Project requirement

 1. **Two players with legal moves**
 2. **Save and Load feature**
 3. **Optional AI**(Still working on it)


## Thoughts About the project
1. I have been looking forward to this project for quite some time. I had a peek on various occasions, and every time that I looked I thought to myself, how should I finish this? Here we are. I FINISHED!
1. I took some time thinking about how I should start, and after some
    thoughts I decided to start with the board and how to represent the
    chess pieces. 
    -  After rendering the board in a way that doesn't look too ugly, I put
    my focus on how to handle the pieces.
    - Started creating classes for each piece and each one of them have their respectively movement, color and special rules. 
   
 2. When the board was handle and the pieces were rendered in the board correctly I started working on the rules like 'en passant' and castle, this was without a doubt the hardest part of this project.
	 -	Many, many bugs happens during the implementation of the rules, well it was my fault for no using rspec for testing.
 4. The save and load feature was "Easy" to implement , I learned the differences between YAML, JSON and Marshal. I decided to use YAML for the simplicity.

## Thoughts after "Finished" the project

Well the project is not over, I still need to implement the AI method and refactor the code, my code is not pretty but am glad with it. I've learned so much in the last month that is hard to put in words how happy am I right now.

Time to take some fresh air.