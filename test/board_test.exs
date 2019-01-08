defmodule BoardTest do
  use ExUnit.Case
  import Board
  import Marks

  @empty_board make_initial_board()

  test "places mark on board" do
    position = 0
    marked_board = @empty_board |> List.replace_at(position, player_one_mark())

    assert place_mark(@empty_board, position, player_one_mark()) == marked_board
  end

  test "returns false if board not full" do
    refute full?(@empty_board)
  end

  test "returns true if board full" do
    full_board = List.duplicate(player_one_mark, 9)
    assert full?(full_board)
  end
end
