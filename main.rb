require_relative 'lib/game.rb'
require_relative 'lib/menu.rb'


puts "Please enter your name:"
name = gets.chomp
menu = Menu.new(name)
menu.play
