defmodule HumanPlayer do
  import Globals, only: [remove_line: 1, newline: 0]
  import CLI, only: [get_number_choice: 1]
  import Prompts, only: [ask_mode_prompt: 0]

  def get_tile_from_human(board) do
    tile_choice = get_number_choice(ask_mode_prompt())
    convert_to_board_position(tile_choice)
  end

  def convert_to_board_position(input) do
    input - 1
  end
end
