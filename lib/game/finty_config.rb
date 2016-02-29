# finty_config.rb
#   Config class for a Finty Flush game.  Supports the 
#   following parameters:
#
#   GAME MODIFIERS:
#
#   cols_droppable (int) - The number of columns the player 
#     is allowed to drop as the result of an impossible move 
#     before the game stops this behavior
#   cols_fail (int) - The number of columns where, if reached, 
#     the game will end
#   cols_max (int) - The maximum size in columns of the top 
#     playing field
#   col_length (int) - The length in cells of each individual 
#     column
#   squares (int) - The number of squares available to the player
#   colors (int) - The amount of colors the top columns can
#     generate columns in
#   starting_cols (int) - The amount of culumns in the top area 
#     at the start of a game
#
#   DISPLAY MODIFIERS:
#
#   squares_per_row (int) - The number of the player's squares 
#     that will appear in each row on the screen

class FintyConfig

  attr_reader :cols_droppable,
              :cols_fail,
              :cols_max,
              :col_length,
              :squares,
              :colors,
              :starting_cols,
              :squares_per_row

  def initialize(hash = {})
    @cols_droppable =  get_data(hash, :cols_droppable,  Fixnum, 25)
    @cols_fail =       get_data(hash, :cols_fail,       Fixnum, 27)
    @cols_max =        get_data(hash, :cols_max,        Fixnum, 29)
    @col_length =      get_data(hash, :col_length,      Fixnum, 4 )
    @squares =         get_data(hash, :squares,         Fixnum, 4 )
    @colors =          get_data(hash, :colors,          Fixnum, 1 )
    @starting_cols =   get_data(hash, :starting_cols,   Fixnum, 10)
    @squares_per_row = get_data(hash, :squares_per_row, Fixnum, 4 )
  end

  private

  def get_data(hash, key, type, def_value)
    (hash and hash[key] and hash[key].class == type) ? 
                                           hash[key] : def_value
  end
end