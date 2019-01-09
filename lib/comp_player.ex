defmodule CompPlayer do
  def get_tile_choice(board) do
    Enum.random(0..length(board))
  end
end
