defmodule Prompts do
  def welcome_prompt, do: ~s{Welcome to Tic Tac Toe!}

  def ask_grid_size_prompt, do: ~s{What size of grid do you desire? Please enter '3' or '4'}

    def invalid_grid_size_prompt, do: ~s{That's not a possible grid size}

  def ask_mode_prompt,
    do:
      ~s{Please select an option:\n'1' for human vs human mode\n'2' for human vs comp mode\n'3' for comp vs human mode\n'4' for comp vs comp mode}

  def invalid_number_prompt,
    do: ~s{That's not a valid number!}

  def invalid_mode_prompt,
    do: ~s{That's not a valid mode choice}

  def introduce_game_prompt, do: ~s{Ready... set... go!}

  def here_board_prompt, do: ~s{Here's the board}

  def ask_tile_prompt, do: ~s{Please enter a tile number}

  def tile_not_in_range_prompt, do: ~s{That's not in range!}

  def tile_occupied_prompt, do: ~s{That tile's taken!}

  def choice_made_prompt, do: ~s{Here's the choice!}

  def win_prompt(mark), do: ~s{Player #{mark} won!}

  def tie_prompt, do: ~s{It was a tie...}

  def ask_replay_prompt, do: ~s{Would you like to play again? Enter 'y' or 'n'}

  def invalid_y_or_n_prompt, do: ~s{That's not a 'y' or 'n'}

  def goodbye_prompt, do: ~s{Thanks for playing, bye!}
end
