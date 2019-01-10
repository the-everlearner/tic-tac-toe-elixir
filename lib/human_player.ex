defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [get_tile_choice: 0]

  def get_tile_from_human(board) do
    convert_to_board_position(get_tile_choice())
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
