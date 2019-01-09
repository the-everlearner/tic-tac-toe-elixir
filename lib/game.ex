defmodule Game do
  import CLI, only: [announce_welcome: 1, turn_end_display: 1, announce_win: 1, announce_tie: 0]
  import Board, only: [place_mark: 3, finished?: 2, won?: 2]
  import HumanPlayer, only: [get_tile_choice: 0]
  import Marks

  def run_game(initial_board, players) do
    announce_welcome(initial_board)
    play_turns(initial_board, List.first(players), List.last(players))
  end

  def play_turns(prev_board, active_player, passive_player) do
    tile_choice = get_tile_choice()
    new_board = place_mark(prev_board, tile_choice, active_player[:mark])
    turn_end_display(new_board)
    if finished?(new_board, active_player[:mark]) do
      do_results(new_board, active_player)
    else
      play_turns(new_board, passive_player, active_player)
    end
  end

  def do_results(board, active_player) do
    if won?(board, active_player[:mark]) do
      announce_win(active_player[:mark])
    else
      announce_tie()
    end
  end
end
