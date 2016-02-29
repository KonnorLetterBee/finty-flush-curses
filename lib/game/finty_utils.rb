# fintyutils.rb
#   A collection of useful methods for Finty Flush

require 'game/finty_config'

class FintyUtils

  # Creates a random column arrangement to fit all of the
  # constraints of the current FintyFlush game
  def FintyUtils.random_col(config)
    return nil unless config.class == FintyConfig
    val = orig_val = rand(1...(config.col_length**2))
    out = []
    (0...config.col_length).each do |idx|
      out.push rand(config.colors) if val%2 == 1
      out.push -1 if val%2 == 0
      val = val >> 1
    end
    #@log.log "#{orig_val.to_s} - #{out.to_s}"
    return out
  end
end