defmodule Game do
  import CLI, only: [introduce_game: 1, turn_end_display: 1, announce_win: 1, announce_tie: 0]
  import Board, only: [finished?: 2, won?: 2]
  import Marks

  def run_game(initial_board, players) do
    introduce_game(initial_board)
    play_turns(initial_board, List.first(players), List.last(players))
  end

  def play_turns(prev_board, active_player, passive_player) do
    mark = active_player[:mark]
    new_board = active_player[:make_move].(prev_board, mark)
    turn_end_display(new_board)
    if finished?(new_board, mark) do
      do_results(new_board, mark)
    else
      play_turns(new_board, passive_player, active_player)
    end
  end

  def do_results(board, mark) do
    if won?(board, mark) do
      announce_win(mark)
    else
      announce_tie()
    end
  end
end
