defmodule Game do
  import CLI, only: [display_welcome: 0]
  import Board, only: [make_initial_board: 0]
  import HumanPlayer, only: [get_tile: 0]

  def run_game do
    board = make_initial_board()
    display_welcome()
    chosen_tile = get_tile()
  end
end
