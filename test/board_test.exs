defmodule BoardTest do
  use ExUnit.Case
  import Board
  import Marks
  Code.require_file("board_helper.exs", __DIR__)

  @empty_board make_initial_board(3)

  test "whether position is in range" do
    assert in_range?(@empty_board, 0) == true
    assert in_range?(@empty_board, 8) == true
    refute in_range?(@empty_board, 9)
    refute in_range?(@empty_board, -1)
  end

  test "return false if tile not occupied" do
    refute tile_occupied?(@empty_board, 0)
  end

  test "return true if tile occupied" do
    board = BoardHelper.generate_marked_board(@empty_board, [0], player_one_mark())

    assert tile_occupied?(board, 0) == true
  end

  test "returns false if game not finished" do
    refute finished?(@empty_board, player_one_mark())
  end

  test "returns true if game finished" do
    won_board = BoardHelper.generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())

    assert finished?(won_board, player_one_mark()) == true
  end

  test "returns false if board not full" do
    refute full?(@empty_board)
  end

  test "returns true if board full" do
    full_board = List.duplicate(player_one_mark(), 9)
    assert full?(full_board) == true
  end

  test "get board dimension (as integer)" do
    assert dimension(@empty_board) === 3
  end

  test "returns false if board not won" do
    not_won_board = BoardHelper.generate_marked_board(@empty_board, [0, 1, 3], player_one_mark())

    refute won?(not_won_board, player_one_mark())
    refute won?(@empty_board, player_one_mark())
  end

  test "check all correct lines are winning on 3x3 board" do
    Enum.each(indices_for_3x3(), fn indices ->
      board = BoardHelper.generate_marked_board(@empty_board, indices, player_one_mark())
      assert won?(board, player_one_mark())
    end)
  end

  test "get empty tiles" do
    board = BoardHelper.generate_marked_board(@empty_board, [0, 1, 3], player_one_mark())
    assert get_empty_tile_positions(board) == [2, 4, 5, 6, 7, 8]
  end

  test "get max depth for 3x3" do
    assert get_max_depth(@empty_board) == 10
  end

  defp indices_for_3x3 do
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end
end
