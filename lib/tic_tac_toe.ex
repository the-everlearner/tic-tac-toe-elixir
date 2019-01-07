defmodule TicTacToe do
  import CLI, only: [initial_prompt: 0]

  def run do
    initial_prompt()
  end
end
