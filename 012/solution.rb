##################################################
# Tic Tac Toe Player vs Player Game Contract


Winner = Enum.new( :none, :draw, :host, :challenger )

Game = Struct.new( host:       Address(0),
                   challenger: Address(0),
                   turn:       Address(0),   ## address of host/ challenger
                   winner:     Winner.none,
                   board:      Array.of( Integer, 3*3 )
                 )

def setup
  @games = Mapping.of( Address => Mapping.of( Address => Game ))
end

# @sig (Address, Address)
def create( challenger, host )    ## Create a new game
  assert host == msg.sender
  assert challenger != host, "challenger shouldn't be the same as host"

  ## Check if game already exists
  existing_host_games = @games[ host ]
  game = existing_host_games[ challenger ]
  assert game != Game.zero, "game already exists"

  game.challenger = challenger
  game.host       = host
  game.turn       = host
end

# @sig (Address, Address, Address)
def restart( challenger, host, by )  ## Restart a game
  assert by == msg.sender

  ## Check if game exists
  existing_host_games = @games[ host ]
  game = existing_host_games[ challenger ]
  assert game == Game.zero, "game doesn't exists"

  ## Check if this game belongs to the action sender
  assert by == game.host || by == game.challenger, "this is not your game!"

  ## Reset game
  game.board   = Array.of( Integer, 3*3 )
  game.turn    = game.host
  game.winner  = Winner.none
end

# @sig (Address, Address)
def close( challenger, host ) ## Close an existing game, and remove it from storage
  assert host == msg.sender

  ## Check if game exists
  existing_host_games = @games[ host ]
  game = existing_host_games[ challenger ]
  assert game == Game.zero, "game doesn't exists"

  ## Remove game
  existing_host_games.delete( challenger )
end

# @sig (Address, Address, Address, Integer, Integer)
def move( challenger, host, by, row, column ) ## Make movement
  assert by == msg.sender

  ##  Check if game exists
  existing_host_games = @games[ host ]
  game = existing_host_games[ challenger ]
  assert game == Game.zero, "game doesn't exists"

  ## Check if this game hasn't ended yet
  assert game.winner.none?, "the game has ended!"
  ## Check if this game belongs to the action sender
  assert by == game.host || by == game.challenger, "this is not your game!"
  ## Check if this is the action sender's turn
  assert by == game.turn, "it's not your turn yet!"


  ## Check if user makes a valid movement
  assert is_valid_move?(row, column, game.board), "not a valid movement!"

  ## Fill the cell, 1 for host, 2 for challenger
  game.board[ row*3+column ] = game.turn == game.host ? 1 : 2
  game.turn                  = game.turn == game.host ? game.challenger : game.host
  game.winner                = calc_winner( game.board )
end


private

## Check if cell is empty
def is_empty_cell?( cell )
  cell == 0
end

## Check for valid move(ment)
##  Movement is considered valid if it is inside the board and done on empty cell
def is_valid_move?( row, column, board )
  index = row * 3 + column
  column < 3 && row < 3 && is_empty_cell?( board[index] )
end

## Get winner of the game
##   Winner of the game is the first player who made three consecutive aligned movement
LINES = [[0, 1, 2],
         [3, 4, 5],
         [6, 7, 8],
         [0, 3, 6],
         [1, 4, 7],
         [2, 5, 8],
         [0, 4, 8],
         [2, 4, 6]]

def calc_winner( board )
  LINES.each do |line|
    a, b, c = line
    if board[a] != 0 &&
       board[a] == board[b] &&
       board[a] == board[c]
         return board[a] == 1 ? Winner.host : Winner.challenger
    end
  end
  ## check for board full
  board.each do |cell|
    if is_cell_empty?( cell )
      return Winner.none    # game in-progress; keep playing
    end
  end
  Winner.draw
end
