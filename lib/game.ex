defmodule Game do
  import CLI, only: [display_welcome: 1, turn_end_display: 1]
  import Board, only: [place_mark: 3, full?: 1]
  import HumanPlayer, only: [get_tile_choice: 0]
  import Marks

  def run_game(initial_board, players) do
    display_welcome(initial_board)
    play_turns(initial_board, List.first(players), List.last(players))
  end

  def play_turns(current_board, active_player, passive_player) do
    if !full?(current_board) do
      tile_choice = get_tile_choice()
      next_board = place_mark(current_board, tile_choice, active_player[:mark])
      turn_end_display(next_board)
      play_turns(next_board, passive_player, active_player)
    else
      IO.puts("Yee haw")
    end
  end
end
