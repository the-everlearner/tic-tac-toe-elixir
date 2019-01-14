defmodule Game do
  import CLI, only: [introduce_game: 1, display_turn: 1, announce_win: 1, announce_tie: 0]
  import Board, only: [finished?: 2, won?: 2]

  def run_game(initial_board, players) do
    introduce_game(initial_board)
    play_turns(initial_board, List.first(players), List.last(players))
  end

  defp play_turns(prev_board, active_player, passive_player) do
    next_board = active_player[:make_move].(prev_board, active_player[:mark])
    display_turn(next_board)
    turn_end(next_board, active_player, passive_player)
  end

  defp turn_end(board, active_player, passive_player) do
    if finished?(board, active_player[:mark]) do
      do_results(board, active_player[:mark])
    else
      play_turns(board, passive_player, active_player)
    end
  end

  defp do_results(board, mark) do
    if won?(board, mark) do
      announce_win(mark)
    else
      announce_tie()
    end
  end
end
