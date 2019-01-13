defmodule CompPlayer do
  import Board, only: [place_mark: 3, won?: 2, get_empty_tile_positions: 1, finished?: 2, get_max_depth: 1]
  import Marks

  def make_comp_move(board, player) do
    move = maximise(board, player, get_opponent(player), 0)[:move]
    place_mark(board, move, player)
  end

  def maximise(board, minimaxer, opponent, depth) do
    empty_tile_positions = get_empty_tile_positions(board)

    tiles_with_scores =
      Enum.map(empty_tile_positions, fn position ->
        next_board = place_mark(board, position, minimaxer)

        if finished?(next_board, minimaxer) do
          [move: position, score: score_board(next_board, minimaxer, opponent, depth)]
        else
          [move: position, score: minimise(next_board, minimaxer, opponent, depth + 1)[:score]]
        end
      end)
    find_max(tiles_with_scores)
  end

  def minimise(board, minimaxer, opponent, depth) do
    empty_tile_positions = get_empty_tile_positions(board)

    tiles_with_scores =
      Enum.map(empty_tile_positions, fn position ->
        next_board = place_mark(board, position, opponent)

        if finished?(next_board, opponent) do
          [move: position, score: score_board(next_board, minimaxer, opponent, depth)]
        else
          [move: position, score: maximise(next_board, minimaxer, opponent, depth + 1)[:score]]
        end
      end)
    find_min(tiles_with_scores)
  end

  def score_board(board, minimaxer, opponent, depth) do
    cond do
      won?(board, minimaxer) -> get_max_depth(board) - depth
      won?(board, opponent) -> depth - get_max_depth(board)
      true -> 0
    end
  end

  def get_opponent(player) do
    if player == player_one_mark() do
      player_two_mark()
    else
      player_one_mark()
    end
  end

  def find_max(tiles_with_scores) do
    Enum.reduce(tiles_with_scores, fn current_max_tile, next_tile ->
      if next_tile[:score] > current_max_tile[:score] do
        next_tile
      else
        current_max_tile
      end
    end)
  end

  def find_min(tiles_with_scores) do
    Enum.reduce(tiles_with_scores, fn current_min_tile, next_tile ->
      if next_tile[:score] < current_min_tile[:score] do
        next_tile
      else
        current_min_tile
      end
    end)
  end
end
