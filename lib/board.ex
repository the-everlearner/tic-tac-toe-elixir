defmodule Board do
  import Marks

  @initial_board List.duplicate(empty_mark(), 9)
  def make_initial_board, do: @initial_board

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
    !Enum.member?(board, :empty_mark)
  end

  def won?(board, player_mark) do
    all_indices = get_all_indices(board)
    win_lines = Enum.map(all_indices, fn index_set -> get_marks(index_set, board) end)
    assessed_lines = Enum.map(win_lines, fn line -> line_won?(line, player_mark) end)
    Enum.any?(assessed_lines, fn assessment -> assessment == true end)
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

    first_col =
      Enum.map(starting_points, fn point ->
        Enum.map(starting_points, fn deeper_point ->
          deeper_point * dimension(board) + point
        end)
      end)
  end

  def diag_indices(board) do
    starting_points_one = Enum.to_list(0..(dimension(board) - 1))
    first_diag = Enum.map(starting_points_one, fn point -> point * dimension(board) + point end)
    starting_points_two = Enum.to_list(1..dimension(board))
    second_diag = Enum.map(starting_points_two, fn point -> point * dimension(board) - point end)
    [first_diag, second_diag]
  end

  def get_marks(indices, board) do
    Enum.map(indices, fn index ->
      get_mark(board, index)
    end)
  end

  def get_mark(board, index) do
    Enum.at(board, index)
  end

  def all_player_marks?(marks, player_mark) do
    Enum.all?(marks, fn mark -> mark == player_mark end)
  end

  def dimension(board) do
    trunc(:math.sqrt(length(board)))
  end

  def get_empty_tile_positions(board) do
    indices = 0..length(board)
    marks_with_indices = Enum.zip(board, indices)
    positions = Enum.map(marks_with_indices, fn tile_with_index ->
      if elem(tile_with_index, 0) == empty_mark() do
        elem(tile_with_index, 1)
      else
        nil
      end end)
    Enum.reject(positions, fn position -> is_nil(position) end)
  end

  def generate_marked_board(empty_board, positions, mark) do
    board_indices = 0..length(empty_board)
    marks_with_indices = Enum.zip(empty_board, board_indices)

    Enum.map(marks_with_indices, fn mark_with_index ->
      if Enum.member?(positions, elem(mark_with_index, 1)) do
        mark
      else
        :empty_mark
      end
    end)
  end
end
