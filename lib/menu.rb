class Menu
  require_relative 'game.rb'

  def initialize(player_name)
    @menu_options = ["1: Start New Game", "2: Load Saved Game", "3: Exit Game"]
    @player_name = player_name
  end

  def display_menu
    puts 'Please enter the number that matches your choice:'
    @menu_options.each { |item| puts item }
  end

  def player_input
    display_menu
    input = gets.chomp
    until ['1','2','3'].include?(input)
      display_menu
    end
    return input
  end

  def play
    loop do
      choice = player_input
      case choice
      when '1'
        game = Game.new(@player_name)
        game.play
      when '2'
        game = Game.new(@player_name)
        game.load_file
        game.play
      when '3'
        puts 'Have a nice day!'
        exit
      end
    end
  end
end
