defmodule CompPlayerTest do
  use ExUnit.Case
  import CompPlayer
  import Board
  import Marks

@empty_board List.duplicate(empty_mark(), 9)

  test "makes optimum comp move" do
    board = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7], player_one_mark())
    board_with_made_move = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7, 8], player_one_mark())
    
    assert make_comp_move(board, player_one_mark()) == board_with_made_move
  end

  test "makes optimum comp move 2" do
    board = generate_marked_board(@empty_board, [0, 1], player_one_mark())
    board_with_made_move = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())
    
    assert make_comp_move(board, player_one_mark()) == board_with_made_move
  end

  test "retrieve opposite player mark" do
    assert get_opponent(player_one_mark()) == player_two_mark()
    assert get_opponent(player_two_mark()) == player_one_mark()
  end

  test "scores board positively for win" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())
    
    assert score_board(p1_won_board, player_one_mark(), player_two_mark()) == 10
  end

  test "scores board negatively for loss by minimaxing player" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_two_mark())
    
    assert score_board(p1_won_board, player_one_mark(), player_two_mark()) == -10
  end

  test "scores board 0 if neither win nor loss" do
    assert score_board(@empty_board, player_two_mark(), player_one_mark()) == 0
  end

  test "maximise" do
    board = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7], player_one_mark())
    
    assert maximise(board, player_one_mark(), player_two_mark()) == {8, 10}
  end

  test "find max" do
    tiles_with_scores = [{4, 7}, {7, 9}, {8, -10}]

    assert find_max(tiles_with_scores) == {7, 9}
  end

  test "minimise" do
    board = generate_marked_board(@empty_board, [0, 1, 2, 3, 4, 5, 6, 7], player_two_mark())
    
    assert minimise(board, player_one_mark(), player_two_mark()) == {8, -10}
  end

  test "find min" do
    tiles_with_scores = [{4, 7}, {7, 9}, {8, -10}]

    assert find_min(tiles_with_scores) == {8, -10}
  end
end
