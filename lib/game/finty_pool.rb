# finty_pool.rb
#   Structure representing the top half of the Finty Flush game
#   board. Available columns to the player are collected here
#   and managed according the the constraints of the game.

require 'game/finty_utils'
require 'util/numberutil'

class FintyPool
  
  attr_reader :offset # setter has extra logic

  def initialize(config)
    raise "Invalid config class" unless config.class == FintyConfig
    @config = config
    @cols = []
    (0...@config.starting_cols).each do
      drop_col 1
    end
    center_cols()
  end

  # Returns the current size of the pool, ie. the number of columns
  # that currently exist inside the pool
  def size
    @cols.size
  end

  # Returns the maximum size of the pool, including the number of
  # columns and the offset within the pool those columns are
  def max_size
    @config.cols_max
  end

  # Returns a copy of the list of columns stored in this pool
  def cols
    Array.new(@cols)
  end

  # Returns the column at the specified index
  def col(index)
    (index >= 0 and index < size()) ? @cols[index] : nil
  end

  # Returns the column directly over the center of the board
  # As per the validation methods put in place for the offset,
  # it is guaranteed to return a non-nil value as long as at
  # least one element exists in the pool.
  def col_center
    col(mid_board - offset)
  end

  # Alternative version of the offset setter that also verifies the
  # offset value is valid
  def offset= (val)
    @offset = val
    validate
  end

  # Removes and returns the column at the specified index
  def delete(index)
    @cols.delete_at(index)
  end

  def delete_center
    @cols.delete_at(mid_board - offset)
  end

  # Adds a new random column to one side of the current board
  #   dir [int] - the comparison vale denoting the drop location 
  #   relative to the rest of the array to place the new column
  #   (positive will append, negative will prepend)
  def drop_col(dir)
    @cols.push FintyUtils.random_col(@config) if dir > 0
    @cols.unshift FintyUtils.random_col(@config) if dir < 0
    @offset -= 1 if dir < 0
  end

  # Calculates the index of the middle column in the board, 
  # favoring the left in the event of an even number of columns
  def mid_board
    mid = @config.cols_max / 2
    @config.cols_max%2 == 0 ? mid-1 : mid
  end

  # Calculates the index of the middle column in the list of
  # usable columns, favoring the left in the event of an even 
  # number of columns
  def mid_columns
    mid = @config.starting_cols / 2
    @config.starting_cols%2 == 0 ? mid-1 : mid
  end

  private

  # Adjusts the offset of this pool such that the available columns
  # are centered within the pool
  def center_cols
    @offset = mid_board() - mid_columns()
  end

  def validate
    raise "Pool overflow" if size > max_size
    @offset = NumberUtil.clamp(@offset, 
                               [        0, mid_board-size+1].max, 
                               [mid_board, max_size - size ].min)
  end
end