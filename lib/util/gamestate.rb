# gamestate.rb
#   Contains the base classes for GameState and StateMachine, two
#   very basic components designed to manage application states

class GameState
  
  # Invoked by the state machine when this state is being switched into
  def on_enter(parent);       end
  
  # Invoked by the state machine when this state is being switched away from
  def on_exit(parent);        end
  
  # Returns the state at the given depth
  # This should ONLY be overridden by a state that manages other substates
  def state(depth);     self; end
  
  # Returns the state at the bottom of this state hierarchy
  # This should ONLY be overridden by a state that manages other substates
  def state_last();     self; end

  # Invoked by the game when the player has input a new key to interpret
  def key_input(key);         end

  # Returns the status of the class (default returns the state's class name)
  def status;     self.class; end
end

class StateMachine < GameState

  def initialize()
    @state = nil
    @log = Log.new(5)
  end

  def set(state)
    raise "Invalid state" unless state and state.class <= GameState
    @log.log("State change: #{@state.class} to #{state.class}")
    @state.on_exit(self) if @state
    @state = state
    @state.on_enter(self) if @state
  end

  def on_enter(parent)
    @log.log("State machine gaining focus")
    @state.on_enter(self) if @current_stste
  end

  def on_exit(parent)
    @log.log("State machine #{self} losing focus")
    @state.on_exit(self) if @current_stste
  end

  def state(depth)
    @state.state(depth-1)
  end

  def state_last()
    @state.state_last()
  end

  def key_input(key)
    state_last().key_input(key)
  end

  def status
    state_last().status
  end

  def log
    @log.get
  end
end