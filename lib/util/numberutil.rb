class NumberUtil
  
  # Returns a number (num) "clamped" between a specified minimum (min) 
  # and maximum (max)
  def NumberUtil.clamp(num,min,max)
    raise "Invalid number #{num}" unless num.class == Fixnum
    raise "Invalid number #{min}" unless min.class == Fixnum
    raise "Invalid number #{max}" unless max.class == Fixnum
    raise "max #{max} is lower than min #{min}" if max < min
    [min, num, max].sort[1]
  end
end