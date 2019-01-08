defmodule Game do
  import CLI, only: [display_welcome: 1,
  turn_end_display: 1]
  import Board, only: [make_initial_board: 0,
    place_mark: 3]
  import HumanPlayer, only: [get_tile_choice: 0]
  import Marks

  def run_game do
    old_board = make_initial_board()
    display_welcome(old_board)
    tile_choice = get_tile_choice()
    next_board = place_mark(old_board, tile_choice, player_one_mark())
    turn_end_display(next_board)
  end
end
