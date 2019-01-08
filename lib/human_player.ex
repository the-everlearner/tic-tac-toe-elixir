defmodule HumanPlayer do
  import Prompts, only: [ask_tile: 0]

  def get_tile_choice do
    IO.gets ask_tile()
  end
end
