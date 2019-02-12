class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new}

    place_stones

 
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i| 
      unless i == 6 || i == 13 
        4.times do 
          cup << :stone
        end 
      end 
    end 
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless @cups.include?(start_pos)

    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]

    @cups[start_pos] = [] 

    c_idx = start_pos
    until stones.empty? 
      c_idx += 1 
      c_idx = 0 if c_idx > 13 # this sends it back around the loop 
      #keep looping through, putting stones into each cup, including their own points cup 
      if c_idx == 6
        cups[6] << stones.pop if current_player_name == @name1
      elsif c_idx == 13 
        cups[13] << stones.pop if current_player_name == @name2
      else 
        @cups[c_idx] << stones.pop
      end 
    end 
  
    self.render   
    self.next_turn(c_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx] == 1 
      :switch
    elsif @cups[ending_cup_idx] == 6 || 13
      :prompt
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
    return true if @cups[6].empty? || @cups[13].empty?
    return false 
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
