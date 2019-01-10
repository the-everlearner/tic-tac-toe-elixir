defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [get_tile_choice: 0, tile_not_in_range: 0]
  import Board, only: [in_range?: 2]

  def get_tile_from_human(board) do
    tile_choice = get_tile_choice() |> convert_to_board_position
    if in_range?(board, tile_choice) do
      tile_choice
    else 
      tile_not_in_range()
      get_tile_from_human(board)
    end
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
