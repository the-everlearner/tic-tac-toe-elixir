defmodule BoardTest do
  use ExUnit.Case
  import Board
  import Marks

  @empty_board make_initial_board()

  test "places mark on board" do
    assert place_mark(@empty_board, 0, player_one_mark()) ==
             generate_marked_board(@empty_board, [0], player_one_mark())
  end

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
    board = generate_marked_board(@empty_board, [0], player_one_mark())

    assert tile_occupied?(board, 0) == true
  end

  test "returns false if game not finished" do
    refute finished?(@empty_board, player_one_mark())
  end

  test "returns true if game finished" do
    won_board = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())

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

  test "check all line indices are winning" do
    line_indices = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    Enum.each(line_indices, fn indices ->
      board = generate_marked_board(@empty_board, indices, player_one_mark())
      assert won?(board, player_one_mark())
    end)
  end

  test "returns false if board not won" do
    not_won_board = generate_marked_board(@empty_board, [0, 1, 3], player_one_mark())

    refute won?(not_won_board, player_one_mark())
    refute won?(@empty_board, player_one_mark())
  end

  test "get row indices" do
    assert row_indices(@empty_board) == [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end

  test "get col indices" do
    assert col_indices(@empty_board) == [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
  end

  test "get diag indices" do
    assert diag_indices(@empty_board) == [[0, 4, 8], [2, 4, 6]]
  end

  test "get empty tiles" do
    assert get_empty_tile_positions(@empty_board) == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end
end
