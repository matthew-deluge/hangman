class Display
  def initialize
    @currrent_gallows = [
      ' +---+',
      ' |   +',
      '     |',
      '     |',
      '     |',
      '     |',
      '     |',
      ' ========'
    ]
  end

  def build_gallows(misses)
    case misses
    when 1
      @currrent_gallows[1] = ' 0   |'
    when 2
      @currrent_gallows[2] = ' |   |'
    when 3
      @currrent_gallows[2] = '/|   |'
    when 4
      @currrent_gallows[2] = '/|\  |'
    when 5
      @currrent_gallows[3] = ' |   |'
    when 6
      @currrent_gallows[4] = '/    |'
    when 7
      @currrent_gallows[4] = '/ \  |'
    end
  end

  def display_gallows
    @currrent_gallows.each do |line|
      puts line
      sleep 0.1
    end
    puts ''
  end
end
