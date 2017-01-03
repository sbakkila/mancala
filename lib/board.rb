class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, idx|
      next if idx == 6 || idx == 13
      #these are the store cups, no initial stones

      i = 0
      while i < 4 do
        cup << :stone
        i += 1
      end

    end
  end

  def valid_move?(start_pos)
    if start_pos < 0
      raise "Invalid starting cup"
    elsif start_pos > 12
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    curr_stones = @cups[start_pos]
    @cups[start_pos] = []


    cup_idx = start_pos
    until curr_stones.empty?
      cup_idx += 1
      cup_idx = 0 if cup_idx > 13

      if cup_idx == 6
        @cups[6] << curr_stones.shift if current_player_name == @name1
      elsif cup_idx == 13
        @cups[13] << curr_stones.shift if current_player_name == @name2
      else
        @cups[cup_idx] << curr_stones.shift
      end
    end

    render

    next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6
      :prompt
    elsif ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
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
    @cups[0..6].all? { |cup| cup.empty? } || @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    player1_score = @cups[6].length
    player2_score = @cups[13].length

    if player1_score == player2_score
      :draw
    elsif player1_score > player2_score
      @name1
    else
      @name2
    end
    
  end

end
