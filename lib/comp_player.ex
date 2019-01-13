defmodule CompPlayer do
  import Board,
    only: [place_mark: 3, won?: 2, get_empty_tile_positions: 1, finished?: 2, get_max_depth: 1]

  import Marks

  @tied_score 0

  def make_comp_move(board, player) do
    move = maximise(board, player, get_opponent(player), 0)[:move]
    place_mark(board, move, player)
  end

  def maximise(board, minimaxer, opponent, depth) do
    Enum.reduce(get_empty_tile_positions(board), [move: nil, score: nil], fn next_position,
                                                                             current_set ->
      next_board = place_mark(board, next_position, minimaxer)
      next_score = get_maximiser_score(next_board, minimaxer, opponent, depth)
      get_max_results(current_set, next_position, next_score)
    end)
  end

  def minimise(board, minimaxer, opponent, depth) do
    Enum.reduce(get_empty_tile_positions(board), [move: nil, score: nil], fn next_position,
                                                                             current_set ->
      next_board = place_mark(board, next_position, opponent)
      next_score = get_minimiser_score(next_board, minimaxer, opponent, depth)
      get_min_results(current_set, next_position, next_score)
    end)
  end

  def get_maximiser_score(next_board, minimaxer, opponent, depth) do
    if finished?(next_board, minimaxer) do
      score_board(next_board, minimaxer, opponent, depth)
    else
      minimise(next_board, minimaxer, opponent, depth + 1)[:score]
    end
  end

  def get_minimiser_score(next_board, minimaxer, opponent, depth) do
    if finished?(next_board, opponent) do
      score_board(next_board, minimaxer, opponent, depth)
    else
      maximise(next_board, minimaxer, opponent, depth + 1)[:score]
    end
  end

  def get_max_results(current_set, next_position, next_score) do
    if is_nil(current_set[:score]) || next_score > current_set[:score] do
      [move: next_position, score: next_score]
    else
      current_set
    end
  end

  def get_min_results(current_set, next_position, next_score) do
    if is_nil(current_set[:score]) || next_score < current_set[:score] do
      [move: next_position, score: next_score]
    else
      current_set
    end
  end

  def score_board(board, minimaxer, opponent, depth) do
    cond do
      won?(board, minimaxer) -> get_max_depth(board) - depth
      won?(board, opponent) -> depth - get_max_depth(board)
      true -> @tied_score
    end
  end

  def get_opponent(player) do
    if player == player_one_mark() do
      player_two_mark()
    else
      player_one_mark()
    end
  end
end
