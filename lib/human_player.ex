defmodule HumanPlayer do
  import CLI, only: [get_tile_choice: 1, tile_not_in_range_message: 1, tile_occupied_message: 1]
  import Board, only: [place_mark: 3, in_range?: 2, tile_occupied?: 2]

  def make_human_move(board, mark) do
    tile_choice = get_tile_choice(board) |> convert_to_board_position

    cond do
      !in_range?(board, tile_choice) ->
        tile_not_in_range_message(board)
        make_human_move(board, mark)

      tile_occupied?(board, tile_choice) ->
        tile_occupied_message(board)
        make_human_move(board, mark)

      true ->
        place_mark(board, tile_choice, mark)
    end
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
