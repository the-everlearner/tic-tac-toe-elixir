defmodule TicTacToe do
  import Board, only: [make_initial_board: 1]

  import CLI,
    only: [
      announce_goodbye: 0,
      announce_welcome: 0,
      ask_board_size: 0,
      ask_replay: 0,
      get_mode_choice: 0,
      invalid_board_size_choice: 0,
      invalid_mode_choice: 0
    ]

  import CompPlayer, only: [make_comp_move: 2]
  import Game, only: [run_game: 2]
  import HumanPlayer, only: [make_human_move: 2]
  import Marks

  @possible_board_sizes [3, 4]

  @human :human
  @comp :comp

  def run do
    announce_welcome()
    run_game(get_board(), get_players(get_mode_choice()))
    replay?(ask_replay())
  end

  def replay?(replay_choice) do
    if replay_choice == :yes do
      run()
    else
      announce_goodbye()
    end
  end

  def get_board do
    board_size_choice = ask_board_size()

    if possible_board_size?(board_size_choice) do
      make_initial_board(board_size_choice)
    else
      invalid_board_size_choice()
      get_board()
    end
  end

  def get_players(mode_choice) do
    allocated_mode = allocate_mode(mode_choice)

    if allocated_mode == :invalid_mode_choice do
      invalid_mode_choice()
      get_players(get_mode_choice())
    else
      allocated_mode
    end
  end

  def allocate_mode(mode_choice) do
    case mode_choice do
      1 ->
        players_template(@human, @human)

      2 ->
        players_template(@human, @comp)

      3 ->
        players_template(@comp, @human)

      4 ->
        players_template(@comp, @comp)

      _ ->
        :invalid_mode_choice
    end
  end

  defp players_template(type_1, type_2) do
    [
      [make_move: find_mark_board_fun(type_1), mark: player_one_mark()],
      [make_move: find_mark_board_fun(type_2), mark: player_two_mark()]
    ]
  end

  defp find_mark_board_fun(type) do
    if type == @human do
      &make_human_move/2
    else
      &make_comp_move/2
    end
  end

  defp possible_board_size?(size) do
    Enum.member?(@possible_board_sizes, size)
  end
end
