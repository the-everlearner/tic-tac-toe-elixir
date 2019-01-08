defmodule BoardTest do
  use ExUnit.Case
  import Board
  import Marks

  test "places mark on board" do
    board = make_initial_board()
    position = 0
    marked_board = make_initial_board() |> List.replace_at(position, player_one_mark())

    assert place_mark(board, position, player_one_mark()) == marked_board
  end
end
