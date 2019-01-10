defmodule CompPlayer do
  def make_comp_move(board, player_mark) do
    Enum.random(0..length(board))
  end
end
