defmodule TicTacToe do
  import Game, only: [run_game: 0]

  def run do
    run_game()
  end
end
