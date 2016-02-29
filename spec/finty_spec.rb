require File.expand_path('spec/spec_helper')

describe FintyFlush do
  def finty; subject; end

  def set_fields(a)
    finty.instance_eval{@fields = a}
  end

  def get_fields
    finty.instance_eval{@fields}
  end

  def board_full_without_winner
    set_fields ['O','X','O', 'O','X','O', 'X','O','X']
  end

  board_width = 14

  it "has a VERSION" do
    FintyFlush::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end

  describe 'on startup' do
    it "should draw an empty board on startup" do
      finty.board.should_not include('X')
      finty.board.should_not include('O')
      finty.board.size.should == board_width * 7
    end

    it "should position the cursor in the first position" do
      finty.board.index('[ ]').should == board_width+1
    end
  end

  describe :move do
    {
      [0,0] => 0,
      [1,0] => 1,
      [3,0] => 0,
      [-1,0] => 2,
      [0,1] => 3,
      [0,3] => 0,
      [0,-1] => 6,
    }.each do |move,position|
      it "is at position #{position} when moving from origin to #{move}" do
        finty = TicTacToe.new
        finty.move(*move)
        finty.position.should == position
      end
    end

    it "updates the cursor" do
      finty.move(1,1)
      finty.board.index('[ ]').should == (board_width*3) + 5
    end
  end

  describe :set do
    it "marks the field for the current player" do
      finty.set
      finty.board.index('[X]').should == board_width + 1
    end

    it "switches the player" do
      finty.player.should == 'X'
      finty.set
      finty.player.should == 'O'
      finty.move(1,0)
      finty.set
      finty.player.should == 'X'
    end

    it "does not set an occupied field" do
      finty.set
      finty.set
      finty.board.index('[O]').should == nil
    end

    it "does not switch players when setting an occupied field" do
      finty.set
      finty.set
      finty.player.should == 'O'
    end
  end

  describe :winner do
    it "is nil when no-one has set" do
      finty.winner.should == nil
    end

    it "is nil when no-one has won" do
      board_full_without_winner
      finty.winner.should == nil
    end

    it "finds diagonal" do
      set_fields ['X','O',' ', ' ','X',' ', ' ','O','X']
      finty.winner.should == 'X'
    end

    it "finds vertical" do
      set_fields ['X','O',' ', ' ','O',' ', ' ','O','X']
      finty.winner.should == 'O'
    end

    it "finds horizontal" do
      set_fields ['X','O',' ', 'O','O','O', ' ','X','X']
      finty.winner.should == 'O'
    end

    it "finds multiple" do
      set_fields ['O','O','O', 'X','O','X', ' ','X','O']
      finty.winner.should == 'O'
    end
  end

  describe :ai do
    it "does not move if winner is selected" do
      set_fields(['O','O','O', ' ',' ',' ', ' ',' ',' '])
      finty.ai_move
      finty.player.should == 'X'
    end

    it "does not move if board is full" do
      board_full_without_winner
      finty.ai_move
      finty.player.should == 'X'
    end

    it "makes a move" do
      finty.player.should == 'X'
      finty.ai_move
      finty.player.should == 'O'
    end

    it "prevents opponent from winning" do
      set_fields(['O','O',' ', ' ',' ',' ', ' ',' ',' '])
      finty.ai_move
      get_fields.should == ['O','O','X', ' ',' ',' ', ' ',' ',' ']
    end

    it "tries to win" do
      set_fields(['O','O',' ', 'X','X',' ', ' ',' ',' '])
      finty.ai_move
      get_fields.should == ['O','O',' ', 'X','X','X', ' ',' ',' ']
    end

    it "cannot prevent the inevitable" do
      set_fields(['O','O',' ', 'O','O',' ', ' ',' ',' '])
      finty.ai_move
      get_fields.should == ['O','O','X', 'O','O',' ', ' ',' ',' ']
    end
  end
end