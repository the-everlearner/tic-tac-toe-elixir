defmodule CompPlayerTest do
  use ExUnit.Case
  import CompPlayer
  import Board, only: [make_initial_board: 0, generate_marked_board: 3]
  import Marks

  @empty_board make_initial_board()

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

  test "get highest score set" do
    assert get_max_results([move: nil, score: nil, alpha: -1000, beta: 1000], 2, 6) == [
             move: 2,
             score: 6,
             alpha: 6,
             beta: 1000
           ]

    assert get_max_results([move: 4, score: 8, alpha: 8, beta: 1000], 2, 6) == [
             move: 4,
             score: 8,
             alpha: 8,
             beta: 1000
           ]
  end

  test "get lowest score set" do
    assert get_min_results([move: nil, score: nil, alpha: -1000, beta: 1000], 2, 6) == [
             move: 2,
             score: 6,
             alpha: -1000,
             beta: 6
           ]

    assert get_min_results([move: 4, score: 3, alpha: -1000, beta: 3], 2, 6) == [
             move: 4,
             score: 3,
             alpha: -1000,
             beta: 3
           ]
  end

  test "retrieve opposite player mark" do
    assert get_opponent(player_one_mark()) == player_two_mark()
    assert get_opponent(player_two_mark()) == player_one_mark()
  end

  test "scores board positively for win" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())

    assert score_board(p1_won_board, player_one_mark(), player_two_mark(), 0) == 10
  end

  test "scores board negatively for loss by minimaxing player" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_two_mark())

    assert score_board(p1_won_board, player_one_mark(), player_two_mark(), 0) == -10
  end

  test "scores board 0 if neither win nor loss" do
    assert score_board(@empty_board, player_two_mark(), player_one_mark(), 0) == 0
  end

  test "maximise" do
    assert maximise(board_1_start(), player_one_mark(), player_two_mark(), 0, -1000, 1000) == [
             move: 8,
             score: 0,
             alpha: 0,
             beta: 1000
           ]
  end

  test "minimise" do
    assert minimise(board_1_start(), player_one_mark(), player_two_mark(), 0, -1000, 1000) == [
             move: 8,
             score: -10,
             alpha: -1000,
             beta: -10
           ]
  end

  def board_1_start do
    generate_marked_board(@empty_board, [1, 5, 6], player_one_mark())
    |> List.replace_at(0, player_two_mark())
    |> List.replace_at(2, player_two_mark())
    |> List.replace_at(3, player_two_mark())
    |> List.replace_at(4, player_two_mark())
  end

  def board_1_with_move do
    board_1_start() |> List.replace_at(8, player_two_mark())
  end

  def board_2_start do
    generate_marked_board(@empty_board, [1, 5, 6], player_one_mark())
    |> List.replace_at(0, player_two_mark())
    |> List.replace_at(2, player_two_mark())
    |> List.replace_at(7, player_two_mark())
    |> List.replace_at(8, player_two_mark())
  end

  def board_2_with_move do
    board_2_start() |> List.replace_at(4, player_two_mark())
  end

  def board_3_start do
    generate_marked_board(@empty_board, [1, 5, 8], player_one_mark())
    |> List.replace_at(6, player_two_mark())
    |> List.replace_at(7, player_two_mark())
  end

  def board_3_with_move do
    board_3_start() |> List.replace_at(2, player_two_mark())
  end
end
