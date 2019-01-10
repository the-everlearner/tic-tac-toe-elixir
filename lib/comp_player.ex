defmodule CompPlayer do
  import Board, only: [place_mark: 3, won?: 2, get_empty_tile_positions: 1]
  import Marks

  def make_comp_move(board, player) do
    move = get_best_tile(board, player)
    place_mark(board, move, player)
  end

  def get_best_tile(board, player) do
  end

  def maximise(board, player, opponent) do
    empty_tile_positions = get_empty_tile_positions(board)
    tiles_with_scores = get_scores(board, empty_tile_positions, player, opponent)

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

  def find_max(tiles_with_scores) do
    Enum.reduce(tiles_with_scores, fn current_max_tile, next_tile ->
      if elem(next_tile, 1) > elem(current_max_tile, 1) do
        next_tile
      else
        current_max_tile
      end end)
  end
end
