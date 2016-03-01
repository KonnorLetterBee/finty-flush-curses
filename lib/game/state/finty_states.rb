require 'game/finty_flush'
require 'util/gamestate'

class FintyState < GameState

  def initialize(finty)
    raise "Invalid game object" unless finty.class == FintyFlush
    @game = finty
  end

  def cols_active;     false;  end
  def squares_active;  false;  end
end

class GameColumnState < FintyState

  def key_input(key)
    case key
    when  :left then @game.pool.offset -= 1
    when :right then @game.pool.offset += 1
    when  :down then @game.state.set(GameSquareState.new(@game))
    end
  end

  def cols_active;  true;  end
end

class GameSquareState < FintyState

  def key_input(key)
    case key
    when  :left then @game.sq_offset -= 1
    when :right then @game.sq_offset += 1
    when    :up then @game.state.set(GameColumnState.new(@game))
    end
  end

  def squares_active;  true;  end
end

class GameOverState < FintyState
end

class FintyStateMachine < StateMachine

  alias_method :sm_key_input, :key_input

  def initialize(finty)
    super()
    raise "Invalid game object" unless finty.class == FintyFlush
    @game = finty
    set(GameColumnState.new(finty))
  end

  def key_input(key)
    case key
    when "e" then colstate
    when "d" then sqstate

    when "w" then 
      colstate
      @game.pool.offset -= 1
    when "r" then 
      colstate
      @game.pool.offset += 1
    when "s" then 
      sqstate
      @game.sq_offset -= 1
    when "f" then 
      sqstate
      @game.sq_offset += 1
    when "a" then 
      sqstate
      @game.curr_sq_idx -= 1
    when "g" then 
      sqstate
      @game.curr_sq_idx += 1
    when "q" then
      @game.rotate_curr(-1)
    when "t" then
      @game.rotate_curr(1)
    when " " then @game.drop_current
    else          sm_key_input(key)
    end
  end

  def cols_active;        state_last.cols_active;  end
  def squares_active;  state_last.squares_active;  end

  private

  def colstate;  @game.state.set(GameColumnState.new(@game)); end
  def sqstate;   @game.state.set(GameSquareState.new(@game)); end
end