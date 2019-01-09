defmodule CompPlayer do
  def get_tile_from_comp(board) do
    Enum.random(0..length(board))
  end
end
