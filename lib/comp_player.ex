defmodule CompPlayer do
  import Board, only: [place_mark: 3, won?: 2, get_empty_tile_positions: 1, finished?: 2, get_max_depth: 1]
  import Marks

  def make_comp_move(board, player) do
    move = elem(maximise(board, player, get_opponent(player), 0), 0)
    place_mark(board, move, player)
  end

  def maximise(board, minimaxer, opponent, depth) do
    empty_tile_positions = get_empty_tile_positions(board)

    scores =
      Enum.map(empty_tile_positions, fn position ->
        next_board = place_mark(board, position, minimaxer)

        if finished?(next_board, minimaxer) do
          score_board(next_board, minimaxer, opponent, depth)
        else
          elem(minimise(next_board, minimaxer, opponent, depth + 1), 1)
        end
      end)

    tiles_with_scores = Enum.zip(empty_tile_positions, scores)
    find_max(tiles_with_scores)
  end

  def minimise(board, minimaxer, opponent, depth) do
    empty_tile_positions = get_empty_tile_positions(board)

    scores =
      Enum.map(empty_tile_positions, fn position ->
        next_board = place_mark(board, position, opponent)

        if finished?(next_board, opponent) do
          score_board(next_board, minimaxer, opponent, depth)
        else
          elem(maximise(next_board, minimaxer, opponent, depth + 1), 1)
        end
      end)

    tiles_with_scores = Enum.zip(empty_tile_positions, scores)
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
      if elem(next_tile, 1) > elem(current_max_tile, 1) do
        next_tile
      else
        current_max_tile
      end
    end)
  end

  def find_min(tiles_with_scores) do
    Enum.reduce(tiles_with_scores, fn current_min_tile, next_tile ->
      if elem(next_tile, 1) < elem(current_min_tile, 1) do
        next_tile
      else
        current_min_tile
      end
    end)
  end
end
