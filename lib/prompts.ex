defmodule Prompts do
  def welcome_prompt, do: ~s{Welcome to Tic Tac Toe!}

  def ask_mode_prompt, do: ~s{Please enter '1' for human vs human mode or '2' for human vs comp mode}

  def ask_tile_prompt, do: ~s{Please enter a tile number}

  def choice_made_prompt, do: ~s{Here's the choice!}

  def win_prompt(mark), do: ~s{Player #{mark} won!}

  def tie_prompt, do: ~s{It was a tie...}
end
