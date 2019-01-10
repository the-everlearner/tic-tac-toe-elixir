defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [get_tile_choice: 0, tile_not_in_range_message: 0, tile_occupied_message: 0]
  import Board, only: [in_range?: 2, tile_occupied?: 2]

  def get_tile_from_human(board) do
    tile_choice = get_tile_choice() |> convert_to_board_position
    cond do
      !in_range?(board, tile_choice) -> 
      tile_not_in_range_message()
      get_tile_from_human(board)
      tile_occupied?(board, tile_choice) -> 
        tile_occupied_message()
      get_tile_from_human(board)
      true -> 
        tile_choice
    end
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
