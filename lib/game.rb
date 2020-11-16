# the main game class
class Game
  require 'json'
  attr_reader :solution, :word, :current_display

  def initialize
    @guesses = 0
    @word = new_word.chomp.downcase
    @solution = @word.split('')
    @current_display = Array.new(@solution.length, '_')
    @past_guesses = []
    @current_gallows = Display.new
  end

  def new_word
    filename = 'lib/5desk.txt'
    File.open(filename, 'r').readlines.sample
  end

  def display_progress(display)
    if @guesses <=6 && !check_win
      @current_gallows.display_gallows
      puts "So far your have #{display.join(' ')}"
      print 'You have guessed: '
      @past_guesses.each { |guess| print "#{guess} "}
      puts ''
    end
  end

  def display_loss
    puts 'You lost! So sad...'
    @current_gallows.display_gallows
    puts "You had #{@current_display.join(' ')}"
    print 'You guessed: '
    @past_guesses.each { |guess| print "#{guess} "}
    puts "and your word was #{@word}"
    puts ''
  end

  def display_win
    puts 'You won! Congrats!'
    @current_gallows.display_gallows
    print 'You guessed: '
    @past_guesses.each { |guess| print "#{guess} " }
    puts "And got the word #{@word}"
    puts ''
  end

  def letter?(look_ahead)
    look_ahead =~ /[[:alpha:]]/
  end

  def player_guess
    guess = ''
    until letter?(guess) && guess.length == 1 && !@past_guesses.include?(guess)
      puts 'Please guess a letter'
      guess = gets.downcase.chomp
      puts 'You must guess a new letter' if @past_guesses.include?(guess)
      if guess.downcase == 'save'
        puts 'Saving file'
        save_file
      end
    end
    @past_guesses.push(guess)
    guess
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
      puts "You got it! #{guess} was in the word!\n\n"
    else
      @guesses += 1
      @current_gallows.build_gallows(@guesses)
      response = @guesses == 6 ? "Nope, last guess!\n\n" : "Nope! You have #{7-@guesses} guesses left\n\n"
      puts response
    end
    sleep 0.4
  end

  def check_win
    @solution.join('') == @current_display.join('')
  end

  def save_file
    game_state = {
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
    @guesses = game_state['guesses']
    @word = game_state['word']
    @solution = game_state['solution']
    @current_display = game_state['current_display']
    @past_guesses = game_state['past_guesses']
    display_progress(@current_display)
  end

  def play
    puts "Let's play! Your word is #{@word.length} letters long!"
    until check_win || @guesses >= 7
      check_input(player_guess)
      display_progress(@current_display)
    end
    check_win ? display_win : display_loss
  end
end
