defmodule Prompts do
  def welcome_prompt, do: ~s{Welcome to Tic Tac Toe!}

  def ask_mode_prompt,
    do: ~s{Please enter '1' for human vs human mode or '2' for human vs comp mode}

  def invalid_number_prompt,
    do: ~s{That's not a valid number!}

  def invalid_mode_prompt,
    do: ~s{That's not a valid mode choice}

  def introduce_game_prompt, do: ~s{And let's go! Here's the board}

  def ask_tile_prompt, do: ~s{Please enter a tile number}

  def tile_not_in_range_prompt, do: ~s{That's not in range!}

  def tile_occupied_prompt, do: ~s{That tile's taken!}

  def choice_made_prompt, do: ~s{Here's the choice!}

  def win_prompt(mark), do: ~s{Player #{mark} won!}

  def tie_prompt, do: ~s{It was a tie...}
end
