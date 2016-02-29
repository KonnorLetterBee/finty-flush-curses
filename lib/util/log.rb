# log.rb
#   Small utility class for collecting log messages that can 
#   be easily displayed in dispel windows
#
#   Currently supports dumb collection of messages and a 
#   log length limit

class Log

  def initialize(max_length = 10)
    @max_length = max_length
    @log = []
  end

  # Appends a new message to the log
  def log(entry)
    @log.push entry
    @log.shift if @log.size > @max_length
  end

  # Returns a copy of the current state of the log array
  def get
    return Array.new(@log)
  end

  # Clears the log of all messages
  def clear
    @log.clear
  end
end