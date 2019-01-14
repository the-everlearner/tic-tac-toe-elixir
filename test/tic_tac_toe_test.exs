defmodule TicTacToeTest do
  use ExUnit.Case
  import TicTacToe
  import Marks
  import HumanPlayer, only: [make_human_move: 2]
  import CompPlayer, only: [make_comp_move: 2]

  test "get players" do
    assert get_players(1) == 
    [
      [make_move: &make_human_move/2, mark: player_one_mark()],
      [make_move: &make_human_move/2, mark: player_two_mark()]
    ]
    assert get_players(2) == 
    [
      [make_move: &make_human_move/2, mark: player_one_mark()],
      [make_move: &make_comp_move/2, mark: player_two_mark()]
    ]
    assert get_players(3) == 
    [
      [make_move: &make_comp_move/2, mark: player_one_mark()],
      [make_move: &make_human_move/2, mark: player_two_mark()]
    ]
    assert get_players(4) == 
    [
      [make_move: &make_comp_move/2, mark: player_one_mark()],
      [make_move: &make_comp_move/2, mark: player_two_mark()]
    ]
  end
end
