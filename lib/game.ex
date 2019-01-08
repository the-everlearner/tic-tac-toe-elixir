defmodule Game do
  import CLI, only: [display_welcome: 1, turn_end_display: 1]
  import Board, only: [make_initial_board: 0, place_mark: 3, full?: 1]
  import HumanPlayer, only: [get_tile_choice: 0]
  import Marks

  def run_game do
    old_board = make_initial_board()
    display_welcome(old_board)
    play_turn(old_board)
  end

  def play_turn(old_board) do
    if !full?(old_board) do
    tile_choice = get_tile_choice()
    next_board = place_mark(old_board, tile_choice, player_one_mark())
    turn_end_display(next_board)
      play_turn(next_board)
    else
      IO.puts("Yee haw")
    end
  end
end
