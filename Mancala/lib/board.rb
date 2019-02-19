require 'byebug'
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1 # initialize player 1 
    @name2 = name2 # initialize player 2 
    @cups = Array.new(14) {Array.new} #set up cups 

    place_stones #call place stones method 

 
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i|  # iterate through each cup with its index 
      unless i == 6 || i == 13  #unless cup is an end cup 
        4.times do #shovel a stone into the cup four times 
          cup << :stone
        end 
      end 
    end 
  end

  def valid_move?(start_pos) #define whether the move is valid or not 
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 13 # if an incorrect number is entered, raise error 

    raise "Starting cup is empty" if @cups[start_pos].empty? #if the cup at that position is empty, raise error 
  end

  def make_move(start_pos, current_player_name) #make move with start position and current player 
    stones = @cups[start_pos] #stones will be the array of stones in this particular cup 

    @cups[start_pos] = [] #empty the current starting cup to zero because you are moving all of the stones 

    c_idx = start_pos # set current index to the starting position 
    until stones.empty? #until you have no more stones in your hand 
      c_idx += 1 # go from one index to the next 
      c_idx = 0 if c_idx > 13 # this sends it back around the loop 
      #keep looping through, putting stones into each cup, including their own points cup 
      if c_idx == 6 #if you are at the player1 point cup and you are player one, pop off stones 
        cups[6] << stones.pop if current_player_name == @name1
      elsif c_idx == 13 #if you are at player 2 point cup and your are player 2, pop off stone 
        cups[13] << stones.pop if current_player_name == @name2
      else 
        @cups[c_idx] << stones.pop #otherwise, pop off stone and shovel into cup at current index 
      end 
    end 
  
    self.render   #render the new board 
    self.next_turn(c_idx) #start next turn, what happens next will depend on where person landed 
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 && @name1
      :prompt
    elsif ending_cup_idx == 13 && @name2
      :prompt
    elsif @cups[ending_cup_idx].length == 1 # if the length of ending cup after adding single stone is one, turn is over 
      :switch
    else 
      ending_cup_idx
    end 
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    # return false if @cups[6].length > 0 && @cups[13].length > 0
    # return true if @cups[6].empty? || @cups[13].empty?
    # return true unless @cups[0..5].all? (:stone) || @cups[7..12].include?.any?(:stone)
    # return false if @cups[0..5].include?.any?(:stone) && @cups[7..12].include?.any?(:stone)
    @cups[0..5].all? {|cup| cup.empty?} || @cups[7..12].all? {|cup| cup.empty?}
  end

  def winner
    p1_count = @cups[6].count
    p2_count = @cups[13].count
    if p1_count == p2_count
      :draw
    elsif p2_count > p1_count
      @name2
    else 
      @name1
    end 
    
  end
end
