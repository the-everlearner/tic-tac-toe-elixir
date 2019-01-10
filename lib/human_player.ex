defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [get_tile_choice: 0, tile_not_in_range_message: 0, tile_occupied_message: 0]
  import Board, only: [place_mark: 3, in_range?: 2, tile_occupied?: 2]

  def make_human_move(board, mark) do
    tile_choice = get_tile_choice() |> convert_to_board_position

    cond do
      !in_range?(board, tile_choice) ->
        tile_not_in_range_message()
        make_human_move(board, mark)

      tile_occupied?(board, tile_choice) ->
        tile_occupied_message()
        make_human_move(board, mark)

      true ->
    place_mark(board, tile_choice, mark)
    end
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
