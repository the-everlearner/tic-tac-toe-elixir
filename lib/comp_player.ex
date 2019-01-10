defmodule CompPlayer do
  import Board, only: [place_mark: 3, won?: 2]
  import Marks

  def make_comp_move(board, player) do
    move = get_best_tile(board, player)
    place_mark(board, move, player)
  end

  def get_best_tile(board, player) do
  end

  def maximise(empty_tile_positions, player, opponent) do
  end

  def get_scores(board, empty_tile_positions, player, opponent) do
    scores = Enum.map(empty_tile_positions, fn position ->
    place_mark(board, position, player) |> score_board(player, opponent)
    end)
    Enum.zip(empty_tile_positions, scores)
  end

  def score_board(board, player, opponent) do
    cond do
      won?(board, player) -> 10
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
