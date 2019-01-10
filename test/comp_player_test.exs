defmodule CompPlayerTest do
  use ExUnit.Case
  import CompPlayer
  import Board
  import Marks

@empty_board List.duplicate(empty_mark(), 9)

  test "returns a tile number" do
    board = generate_marked_board(@empty_board, [0], player_one_mark())
  end
end
