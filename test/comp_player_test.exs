defmodule CompPlayerTest do
  use ExUnit.Case
  import CompPlayer
  import Board
  import Marks

@empty_board List.duplicate(empty_mark(), 9)

  test "retrieve opposite player mark" do
    assert get_opponent(player_one_mark()) == player_two_mark()
    assert get_opponent(player_two_mark()) == player_one_mark()
  end

  test "scores board positively for win" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_one_mark())
    
    assert score_board(p1_won_board, player_one_mark(), player_two_mark()) == 10
  end

  test "scores board negatively for loss" do
    p1_won_board = generate_marked_board(@empty_board, [0, 1, 2], player_two_mark())
    
    assert score_board(p1_won_board, player_two_mark(), player_one_mark()) == 10
  end

  test "scores board 0 if neither win nor loss" do
    assert score_board(@empty_board, player_two_mark(), player_one_mark()) == 0
  end
end
