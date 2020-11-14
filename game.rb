# the main game class
class Game
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
    filename = '5desk.txt'
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
      puts "Please guess a new letter" if @past_guesses.include?(guess)
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
      @guesses +=1
      puts "Nope! You have #{8-@guesses} guesses left"
    end
  end

  def check_win
    return @solution.join('') == @current_display.join('')
  end

  def play
    puts "Welcome to Hangman! Your word has been selected, #{@player_name}, and it is #{@word.length} letters long!"
    until check_win || @guesses>=8
      check_input(player_guess)
      display_progress(@current_display)
    end
    response = check_win ? "You won, #{@player_name}, nice work!" : "You lost, #{@player_name}, so sad!"
    puts response
  end

end