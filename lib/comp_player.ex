defmodule CompPlayer do
  import Board, only: [place_mark: 3, won?: 2]
  import Marks

  def make_comp_move(board, player_mark) do
    move = get_best_tile(board, player_mark)
    place_mark(board, move, player_mark)
  end

  def get_best_tile(board, player_mark) do
  end

  def score_board(board, scorer, opponent) do
    cond do
      won?(board, scorer) -> 10
      won?(board, opponent) -> 10
      true -> 0
    end
  end

  def get_opponent(mark) do
    if mark == player_one_mark() do
      player_two_mark()
    else
      player_one_mark()
    end
  end
end
