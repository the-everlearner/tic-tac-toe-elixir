defmodule BoardHelper do
  def generate_marked_board(empty_board, positions, mark) do
    Enum.map(Enum.with_index(empty_board), fn mark_with_index ->
      if Enum.member?(positions, elem(mark_with_index, 1)) do
        mark
      else
        :empty_mark
      end
    end)
  end
end
