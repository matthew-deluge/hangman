# the main game class
class Game
  require 'json'
  attr_reader :solution, :word, :current_display

  def initialize(player_name)
    @player_name = player_name
    @guesses = 0
    @word = new_word.chomp.downcase
    @solution = @word.split('')
    @current_display = Array.new(@solution.length, '_')
    @past_guesses = []
  end

  def new_word
    filename = 'lib/5desk.txt'
    File.open(filename, 'r').readlines.sample
  end

  def display_progress(display)
    puts "So far your have #{display.join(' ')}"
  end

  def letter?(lookAhead)
    lookAhead =~ /[[:alpha:]]/
  end

  def player_guess
    guess = ""
    until letter?(guess)&&guess.length==1&&!@past_guesses.include?(guess)
      puts "Please guess a letter, #{@player_name}"
      guess = gets.chomp
      puts 'Please guess a new letter' if @past_guesses.include?(guess)
      if guess.downcase == 'save'
        puts 'Saving file'
        save_file
      end
    end
    @past_guesses.push(guess)
    return guess
  end

  def update_display(guess)
    @solution.each_with_index do |letter, index|
      if letter == guess
        @current_display[index] = letter
      end
    end
  end

  def check_input(guess)
    if solution.include?(guess)
      update_display(guess)
      puts "You got it, #{@player_name}! #{guess} was in the word!"
    else
      @guesses += 1
      puts "Nope! You have #{8-@guesses} guesses left"

    end
  end

  def check_win
    @solution.join('') == @current_display.join('')
  end

  def save_file
    game_state = {
      name: @player_name,
      guesses: @guesses,
      word: @word,
      solution: @solution,
      current_display: @current_display,
      past_guesses: @past_guesses
    }.to_json
    File.open('lib/save_data.json', 'w') { |file| file.write(game_state) }
    puts 'File saved, thank you for playing!'
    exit
  end

  def load_file
    file = File.read('lib/save_data.json')
    game_state = JSON.parse(file)
    @player_name = game_state['player_name']
    @guesses = game_state['guesses']
    @word = game_state['word']
    @solution = game_state['solution']
    @current_display = game_state['current_display']
    @past_guesses = game_state['past_guesses']
  end

  def play
    puts "Welcome to Hangman! Your word has been selected, #{@player_name}, and it is #{@word.length} letters long!"
    until check_win || @guesses >= 8
      check_input(player_guess)
      display_progress(@current_display)
    end
    response = check_win ? "You won, #{@player_name}, nice work!" : "You lost, #{@player_name}, so sad!"
    puts response
  end
end
