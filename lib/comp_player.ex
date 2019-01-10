defmodule CompPlayer do
  import Board, only: [place_mark: 3]

  def make_comp_move(board, player_mark) do
    move = Enum.random(0..length(board) - 1)
    place_mark(board, move, player_mark)
  end
end
