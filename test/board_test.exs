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
    full_board = List.duplicate(player_one_mark(), 9)
    assert full?(full_board) == true
  end

  test "get board dimension" do
    assert dimension(@empty_board) === 3
  end

  test "returns false if board not won" do
    refute won?(@empty_board, player_one_mark())
  end

  test "top row win" do
    board = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "mid row win" do
    board = generate_marked_board(@empty_board, [3, 4, 5], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "bot row win" do
    board = generate_marked_board(@empty_board, [6, 7, 8], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "first col win" do
    board = generate_marked_board(@empty_board, [0, 3, 6], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "mid col win" do
    board = generate_marked_board(@empty_board, [1, 4, 7], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "end col win" do
    board = generate_marked_board(@empty_board, [2, 5, 8], player_one_mark())

    assert won?(board, player_one_mark())
  end

  test "get all indices" do
    assert get_all_indices(@empty_board) == [
             [0, 1, 2],
             [3, 4, 5],
             [6, 7, 8],
             [0, 3, 6],
             [1, 4, 7],
             [2, 5, 8]
           ]
  end

  test "get row indices" do
    assert row_indices(@empty_board) == [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end

  test "get col indices" do
    assert col_indices(@empty_board) == [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
  end

  def generate_marked_board(empty_board, positions, mark) do
    board_indices = 0..length(empty_board)
    marks_with_indices = Enum.zip(empty_board, board_indices)
    Enum.map(marks_with_indices, fn mark_with_index -> 
      if Enum.member?(positions, elem(mark_with_index, 1)) do
        mark
      else
        :empty_mark
      end
    end)
  end

  test "test function - generate marked board" do
    assert generate_marked_board(@empty_board, [0, 1, 2], player_one_mark()) == 
      @empty_board |> List.replace_at(0, player_one_mark())
       |> List.replace_at(1, player_one_mark())
       |> List.replace_at(2, player_one_mark())
  end
end
