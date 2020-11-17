module Instructables
  INSTRUCTIONS = "Welcome to Hangman! This is the world-famous word-guessing game with a dark and very outdated theme!\n\n\
The purpose of the game is to guess the secret word, chosen randomly from a dictionary of words.\n\
If you guess a letter in the word, hooray! It will show up on your board.\n\
If you guess incorrectly, you are one step closer...to the end!\n\n\
While you are playing, you can type 'save' and your game will save for later.\n\n"
  def print_instructions
    puts INSTRUCTIONS
  end
end
