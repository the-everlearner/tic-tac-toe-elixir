defmodule HumanPlayer do
  import Prompts, only: [ask_tile_prompt: 0]
  import Globals, only: [remove_line: 1, newline: 0]

  def get_tile_choice do
    input = IO.gets(ask_tile_prompt() <> newline())
    convert_choice(input)
  end

  def convert_choice(input) do
    String.to_integer(remove_line(input)) - 1
  end
end
