defmodule TicTacToe do
  import Board, only: [make_initial_board: 0]
  import Game, only: [run_game: 2]
  import Marks
  import PlayerTypes

  def run do
    initial_board = make_initial_board()
    run_game(initial_board, get_players())
  end

  def get_players do
    player_one = [type: human(), mark: player_one_mark()]
    player_two = [type: human(), mark: player_two_mark()]
    [player_one, player_two]
  end
end
