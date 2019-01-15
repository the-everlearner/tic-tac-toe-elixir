defmodule GameTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Game
  Code.require_file("board_helper.exs", __DIR__)
  import Board, only: [make_initial_board: 1]
  import Marks
  import TicTacToe, only: [get_players: 1]

  test "integration test that game runs ending with a 'won' message when comp player wins" do
    board = BoardHelper.generate_marked_board(make_initial_board(3), [0, 1], player_one_mark())
    players = get_players(4)

    assert capture_io(fn -> run_game(board, players) end) =~ "won"
  end
end
