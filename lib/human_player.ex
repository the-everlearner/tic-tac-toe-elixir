defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [ask_tile_choice: 0]

  def get_tile_choice do
    input = ask_tile_choice()
    convert_to_board_position(input)
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
