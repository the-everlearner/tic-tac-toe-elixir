defmodule BoardTest do
  use ExUnit.Case
  import Board
  import Marks
  Code.require_file("board_helper.exs", __DIR__)

  @empty_3x3 List.duplicate(empty_mark(), 9)
  @empty_4x4 List.duplicate(empty_mark(), 16)

  test "make initial board" do
    assert make_initial_board(3) == @empty_3x3
    assert make_initial_board(4) == @empty_4x4
  end

  test "get board dimension (as integer)" do
    assert dimension(@empty_3x3) === 3
    assert dimension(@empty_4x4) === 4
  end

  test "whether position is in range" do
    assert in_range?(@empty_3x3, 0) == true
    assert in_range?(@empty_3x3, 8) == true
    refute in_range?(@empty_3x3, 9)
    refute in_range?(@empty_3x3, -1)
  end

  test "return false if tile not occupied" do
    refute tile_occupied?(@empty_3x3, 0)
  end

  test "return true if tile occupied" do
    board = BoardHelper.generate_marked_board(@empty_3x3, [0], player_one_mark())

    assert tile_occupied?(board, 0) == true
  end

  test "return false if game not finished" do
    refute finished?(@empty_3x3, player_one_mark())
  end

  test "return true if game finished" do
    won_board = BoardHelper.generate_marked_board(@empty_3x3, [0, 1, 2], player_one_mark())

    assert finished?(won_board, player_one_mark()) == true
  end

  test "returns false if board not full" do
    refute full?(@empty_3x3)
  end

  test "returns true if board full" do
    full_board = List.duplicate(player_one_mark(), 9)

    assert full?(full_board) == true
  end

  test "returns false if board not won" do
    not_won_board = BoardHelper.generate_marked_board(@empty_3x3, [0, 1, 3], player_one_mark())

    refute won?(not_won_board, player_one_mark())
    refute won?(@empty_3x3, player_one_mark())
  end

  test "check all correct lines are winning on 3x3 board" do
    test_winning_lines(@empty_3x3, indices_for_3x3())
  end

  test "check all correct lines are winning on 4x4 board" do
    test_winning_lines(@empty_4x4, indices_for_4x4())
  end

  test "get empty tiles" do
    board = BoardHelper.generate_marked_board(@empty_3x3, [0, 1, 3], player_one_mark())
    assert get_empty_tile_positions(board) == [2, 4, 5, 6, 7, 8]
  end

  test "get max depth" do
    assert get_max_depth(@empty_3x3) == 10
    assert get_max_depth(@empty_4x4) == 17
  end

  defp test_winning_lines(board, indices) do
    Enum.each(indices, fn indices ->
      board = BoardHelper.generate_marked_board(board, indices, player_one_mark())
      assert won?(board, player_one_mark()) == true
    end)
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

  defp indices_for_4x4 do
    [
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [8, 9, 10, 11],
      [12, 13, 14, 15],
      [0, 4, 8, 12],
      [1, 5, 9, 13],
      [2, 6, 10, 14],
      [3, 7, 11, 15],
      [0, 5, 10, 15],
      [3, 6, 9, 12]
    ]
  end
end
