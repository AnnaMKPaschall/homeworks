class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1 
    @game_over = false 
    @seq = []
  end

  def play
    until game_over == true 
      take_turn
      system("clear")
    end 
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless @game_over
      self.round_success_message
      @sequence_length += 1 
    end 
  end

  def show_sequence
    self.add_random_color

  end

  def require_sequence
    puts "Do you best to remember the sequence and key it back exactly!"
    @seq.each do |color|
      color_guess = gets.chomp 
      if color_guess != color 
        @game_over = true 
      end 
    end 
  end

  def add_random_color
    @seq << COLORS.shuffle[0]
  end

  def round_success_message
    puts "Well done, you made it through another round"
  end

  def game_over_message
    puts "You have lost the game. Goodbye"
  end

  def reset_game
    @game_over = false 
    @seq = []
    @sequence_length = 1 
  end

end
