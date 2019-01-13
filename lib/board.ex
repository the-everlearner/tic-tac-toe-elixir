defmodule Board do
  import Marks

  def make_initial_board(grid_size) do
    List.duplicate(empty_mark(), grid_size * grid_size)
  end

  def place_mark(board, position, mark) do
    List.replace_at(board, position, mark)
  end

  def in_range?(board, position) do
    Enum.member?(0..(length(board) - 1), position)
  end

  def tile_occupied?(board, position) do
    Enum.at(board, position) != empty_mark()
  end

  def finished?(board, player_mark) do
    won?(board, player_mark) || full?(board)
  end

  def full?(board) do
    !Enum.member?(board, empty_mark())
  end

  def won?(board, player_mark) do
    all_indices = get_all_indices(board)
    win_lines = Enum.map(all_indices, fn index_set -> get_marks(index_set, board) end)
    assessed_lines = Enum.map(win_lines, fn line -> line_won?(line, player_mark) end)
    Enum.member?(assessed_lines, true)
  end

  def line_won?(line, player_mark) do
    Enum.all?(line, fn mark -> mark == player_mark end)
  end

  def get_all_indices(board) do
    row_indices(board) ++ col_indices(board) ++ diag_indices(board)
  end

  def row_indices(board) do
    board_indices = 0..length(board)
    Enum.chunk_every(board_indices, dimension(board), dimension(board), :discard)
  end

  def col_indices(board) do
    starting_points = 0..(dimension(board) - 1)

    Enum.map(starting_points, fn point ->
      generate_single_col(board, starting_points, point)
    end)
  end

  defp generate_single_col(board, starting_points, point) do
    Enum.map(starting_points, fn deeper_point ->
      deeper_point * dimension(board) + point
    end)
  end

  def diag_indices(board) do
    starting_points_one = Enum.to_list(0..(dimension(board) - 1))
    first_diag = Enum.map(starting_points_one, fn point -> point * dimension(board) + point end)

    starting_points_two = Enum.to_list(1..dimension(board))
    second_diag = Enum.map(starting_points_two, fn point -> point * dimension(board) - point end)

    [first_diag, second_diag]
  end

  defp get_marks(indices, board) do
    Enum.map(indices, fn index ->
      get_mark(board, index)
    end)
  end

  defp get_mark(board, index) do
    Enum.at(board, index)
  end

  def dimension(board) do
    trunc(:math.sqrt(length(board)))
  end

  def get_empty_tile_positions(board) do
    Enum.flat_map(Enum.with_index(board), fn tile_with_index ->
      if elem(tile_with_index, 0) == empty_mark() do
        [elem(tile_with_index, 1)]
      else
        []
      end
    end)
  end

  def generate_marked_board(empty_board, positions, mark) do
    Enum.map(Enum.with_index(empty_board), fn mark_with_index ->
      if Enum.member?(positions, elem(mark_with_index, 1)) do
        mark
      else
        :empty_mark
      end
    end)
  end

  def get_max_depth(board) do
    length(board) + 1
  end
end
