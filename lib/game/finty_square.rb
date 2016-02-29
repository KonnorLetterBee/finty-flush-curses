class FintySquare

  def initialize(size)
    @square = []
    @size = size
    (0...size).each do |x|
      @square.push []
      (0...size).each do
        @square[x].push -1
      end
    end
  end

  # Returns a copy of the 2D array representing the data
  # stored in this FintySquare
  def square
    out = []
    (0...@size).each do |x|
      out.push Array.new(@square[x])
    end
    return out
  end

  # Sets a value for a cell in the square
  def set(x,y,value)
    valid = x >= 0 and y >= 0 and x < @size and y < @size and value.class == Fixnum
    @square[x][y] = value if valid
  end

  # Sets a value for an entire column in the square, 
  # overwriting the old value of the column
  def set_col(x,col)
    valid = x >= 0 and x < @size and col.class == Array and col.size == @size
    @square[x] = Array.new(col) if valid
  end

  # Performs a "drop" action on the square, given a column to
  # drop.  A drop is an additive function where a value that
  # exists in the dropping column will overwrite an EMPTY space
  # in the corresponding index in the square. If ANY of the spaces
  # have a conflict, the drop will fail.
  def drop_col(x,col,force=false)
    false unless verify_size(x) and verify_col(col)
    false unless can_drop(x,col) or force
    (0...@size).each do |y|
      @square[x][y] = col[y] unless col[y] == -1
    end
    true
  end

  # Tests to see if a "drop" action can be performed on the square 
  # at a given column and target index to drop to.
  #
  # See also: drop_col(x,col,force)
  def can_drop(x,col)
    false unless verify_size(x) and verify_col(col)
    (0...@size).each do |y|
      false unless @square[x][y] == -1 or col[y] == -1
    end
    true
  end

  def get(x,y)
    @square[x][y]
  end

  # Rotates the FintySquare 90 degrees in a particular 
  # direction. Positive values indicate a clockwise turn, 
  # negative values indicate a counter-clockwise turn
  #
  # This version of matrix rotation utilizes no extra memory
  # for another version of the square.  Instead, the cells
  # are rotated four at a time, starting with the corners,
  # working towards the center in a triangle pattern.
  def rotate(dir)
    (0...@size/2).each do |x|
      (x...@size-1-x).each do |y|
        a = [        x,        y]
        b = [@size-1-y,        x]
        c = [@size-1-x,@size-1-y]
        d = [        y,@size-1-x]
        if dir > 0
          swap_cells(a,b)
          swap_cells(a,c)
          swap_cells(a,d)
        elsif dir < 0
          swap_cells(a,d)
          swap_cells(a,c)
          swap_cells(a,b)
        end
      end
    end
  end

  private

  def swap_cells(a=[0,0], b=[0,0])
    a_v = @square[a[0]][a[1]]
    @square[a[0]][a[1]] = @square[b[0]][b[1]]
    @square[b[0]][b[1]] = a_v
  end

  def verify_size(size)
    size >= 0 and size < @size
  end

  def verify_col(col)
    col.class == Array and col.size == @size
  end
end