defmodule CompPlayerTest do
  use ExUnit.Case
  import Board, only: [make_initial_board: 1]
  import CompPlayer
  import Marks
  Code.require_file("board_helper.exs", __DIR__)

  @empty_board make_initial_board(3)

  test "make comp move - 1" do
    _ = """
    O X O
    O O X
    X 8 9
    Optimum move for O player: 9
    """

    assert make_comp_move(board_1_start(), player_two_mark()) == board_1_with_move()
  end

  test "make comp move - 2" do
    _ = """
    O X O
    4 5 X
    X O O
    Optimum move for O player: 5
    """

    assert make_comp_move(board_2_start(), player_two_mark()) == board_2_with_move()
  end

  test "make comp move - 3 - to lose in as many turns as possible, testing depth" do
    _ = """
    1 X 3
    4 5 X
    O O X
    Optimum move for O player: 3
    """

    assert make_comp_move(board_3_start(), player_two_mark()) == board_3_with_move()
  end

  def board_1_start do
    BoardHelper.generate_marked_board(@empty_board, [1, 5, 6], player_one_mark())
    |> List.replace_at(0, player_two_mark())
    |> List.replace_at(2, player_two_mark())
    |> List.replace_at(3, player_two_mark())
    |> List.replace_at(4, player_two_mark())
  end

  def board_1_with_move do
    board_1_start() |> List.replace_at(8, player_two_mark())
  end

  def board_2_start do
    BoardHelper.generate_marked_board(@empty_board, [1, 5, 6], player_one_mark())
    |> List.replace_at(0, player_two_mark())
    |> List.replace_at(2, player_two_mark())
    |> List.replace_at(7, player_two_mark())
    |> List.replace_at(8, player_two_mark())
  end

  def board_2_with_move do
    board_2_start() |> List.replace_at(4, player_two_mark())
  end

  def board_3_start do
    BoardHelper.generate_marked_board(@empty_board, [1, 5, 8], player_one_mark())
    |> List.replace_at(6, player_two_mark())
    |> List.replace_at(7, player_two_mark())
  end

  def board_3_with_move do
    board_3_start() |> List.replace_at(2, player_two_mark())
  end
end
