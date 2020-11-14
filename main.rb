require_relative 'game.rb'


puts "Please enter your name:"
name = gets.chomp
game = Game.new(name)
game.play