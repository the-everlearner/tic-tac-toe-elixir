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
    board = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7], player_one_mark())

    assert maximise(board, player_one_mark(), player_two_mark(), 0) == [move: 8, score: 10]
  end

  test "find max" do
    tiles_with_scores = [[move: 4, score: 7], [move: 7, score: 9], [move: 8, score: -10]]

    assert find_max(tiles_with_scores) == [move: 7, score: 9]
  end

  test "minimise" do
    board = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7], player_two_mark())

    assert minimise(board, player_one_mark(), player_two_mark(), 0) == [move: 8, score: -10]
  end

  test "find min" do
    tiles_with_scores = [[move: 4, score: 7], [move: 7, score: 9], [move: 8, score: -10]]

    assert find_min(tiles_with_scores) == [move: 8, score: -10]
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
