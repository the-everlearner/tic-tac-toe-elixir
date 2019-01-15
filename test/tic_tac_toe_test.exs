defmodule TicTacToeTest do
  use ExUnit.Case
  import TicTacToe
  import Marks
  import HumanPlayer, only: [make_human_move: 2]
  import CompPlayer, only: [make_comp_move: 2]

  test "allocate mode" do
    assert allocate_mode(1) ==
             [
               [make_move: &make_human_move/2, mark: player_one_mark()],
               [make_move: &make_human_move/2, mark: player_two_mark()]
             ]

    assert allocate_mode(2) ==
             [
               [make_move: &make_human_move/2, mark: player_one_mark()],
               [make_move: &make_comp_move/2, mark: player_two_mark()]
             ]

    assert allocate_mode(3) ==
             [
               [make_move: &make_comp_move/2, mark: player_one_mark()],
               [make_move: &make_human_move/2, mark: player_two_mark()]
             ]

    assert allocate_mode(4) ==
             [
               [make_move: &make_comp_move/2, mark: player_one_mark()],
               [make_move: &make_comp_move/2, mark: player_two_mark()]
             ]
    
    assert allocate_mode(5) == :invalid_mode_choice
  end
end
