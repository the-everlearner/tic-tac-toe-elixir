defmodule Board do
  import Marks

  @initial_board List.duplicate(empty_mark(), 9)
  def make_initial_board, do: @initial_board

  def place_mark(board, position, mark) do
    List.replace_at(board, position, mark)
  end

  def full?(board) do
    !Enum.member?(board, :empty_mark)
  end
end
