# finty_flush.rb
#   Contains the entire structure required to play a
#   game of Finty Flush.

require 'game/finty_config'
require 'game/finty_pool'
require 'game/finty_square'
require 'game/state/finty_states'
require 'finty_flush/version'
require 'util/log'
require 'util/specialchars'

class FintyFlush

  attr_reader :pool, :state, :sq_offset, :curr_sq_idx

  def initialize(config = FintyConfig.new)
    raise "Invalid config class #{config.class}" unless config.class == FintyConfig
    @config = config
    @log = Log.new(8)
    @pool = FintyPool.new(config)
    @squares = []
    @curr_sq_idx = 0
    @sq_offset = 0
    (0...@config.squares).each do
      @squares.push FintySquare.new(@config.col_length)
    end
    @state = FintyStateMachine.new(self)
  end

#-----------------------------------------------
# Accessors / Mutators
#-----------------------------------------------

  def status
    @state.status
  end

  def sq_offset=(val)
    @sq_offset = NumberUtil.clamp(val, 0, @config.col_length - 1)
  end

  def curr_sq_idx=(val)
    @curr_sq_idx = val if val >= 0 and val < @config.squares
  end

  def curr_square
    @squares[@curr_sq_idx]
  end

  def log
    return @log.get
  end

#-----------------------------------------------
# Game Functions
#-----------------------------------------------

  def rotate_curr(dir)
    curr_square.rotate(dir)
  end

  def drop_current
    @pool.delete_center if curr_square.drop_col(@sq_offset, @pool.col_center)
  end

#-----------------------------------------------
# The Print Method
#-----------------------------------------------

  # Returns a string representation of the current game
  def board
    #TODO: sort out this fucking draw function
    active = state.cols_active
    out = (active ? $╔ : $┌)
    out += (active ? $═ : $─)*@pool.max_size()
    out += (active ? $╗ : $┐)+"\n"
    ( 0...@config.col_length ).each do |row|
      out += state.cols_active ? $║ : $│
      ( 0...@pool.max_size() ).each do |col|
        index = col - @pool.offset()
        col = index >= 0 ? @pool.col(index) : nil
        val = col ? col[row] : -1;
        out += (val == -1) ? ' ' : val.to_s
      end
      out += (state.cols_active ? $║ : $│)+"\n"
    end

    max = @pool.max_size
    mid = @pool.mid_board
    out += (active ? $╚ : $└)
    out += (active ? $═ : $─)*(mid-1)
    out += (active ? "╗ ╔" : "┐ ┌")
    out += (active ? $═ : $─)*(max-(mid+2))
    out += (active ? $╝ : $┘) + "\n\n+"

    ( 0...@config.squares_per_row ).each do
      out += "-"*@config.col_length*2 + "+"
    end
    out += "\n"
    # for each row of @config.squares
    ( 0...(@config.squares/@config.squares_per_row.to_f).ceil ).each do |sq_row|
      # for each row in an individual square
      ( 0...@config.col_length ).each do |y|
        row_start = sq_row * @config.squares_per_row
        out += "|"
        # for each square in the row of @config.squares
        ( row_start ... row_start + @config.squares_per_row ).each do |sq|
          # for each column in the current square
          ( 0...@config.col_length ).each do |x|
            val = @squares[sq].get(x, y)
            out += val == -1 ? "  " : format("%2d", val)
          end;  out += "|"
        end;  out += "\n"
      end;  out += "+"
      ( 0...@config.squares_per_row ).each do
        out += "-"*@config.col_length*2 + "+"
      end;  out += "\n"
    end;
    sq_char_w = @config.col_length * 2 + 1
    out += " "*(1+(sq_char_w * @curr_sq_idx)+@sq_offset * 2) + "^"
    out += "\n"
  end
end
