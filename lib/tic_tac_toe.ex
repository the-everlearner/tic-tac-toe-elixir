defmodule TicTacToe do
  import Board, only: [make_initial_board: 0]
  import Game, only: [run_game: 2]
  import Marks
  import CLI, only: [announce_welcome: 0, get_mode_choice: 0, invalid_mode_choice: 0, announce_goodbye: 0, ask_replay: 0]
  import HumanPlayer, only: [make_human_move: 2]
  import CompPlayer, only: [make_comp_move: 2]

  @hvh :hvh
  @hvc :hvc
  @cvh :cvh
  @cvc :cvc

  @yes :yes
  @no :no

  def run do
    announce_welcome()
    run_game(make_initial_board(), get_players())
    replay_choice = find_replay_choice(ask_replay())
    if replay_choice == @yes do
      run()
    else
      announce_goodbye()
    end
  end

  def find_replay_choice(choice) do
    if choice == "y" do
      @yes
    else
      @no
    end
  end

  def get_players do
    mode = find_mode()
    make_players(mode)
  end

  def find_mode do
    case get_mode_choice() do
      1 ->
        @hvh

      2 ->
        @hvc

      3 ->
        @cvh

      4 ->
        @cvc

      _ ->
        invalid_mode_choice()
        find_mode()
    end
  end

  def make_players(mode) do
    case mode do
      @hvh ->
        [
          [make_move: &make_human_move/2, mark: player_one_mark()],
          [make_move: &make_human_move/2, mark: player_two_mark()]
        ]

      @hvc ->
        [
          [make_move: &make_human_move/2, mark: player_one_mark()],
          [make_move: &make_comp_move/2, mark: player_two_mark()]
        ]

      @cvh ->
        [
          [make_move: &make_comp_move/2, mark: player_one_mark()],
          [make_move: &make_human_move/2, mark: player_two_mark()]
        ]

      @cvc ->
        [
          [make_move: &make_comp_move/2, mark: player_one_mark()],
          [make_move: &make_comp_move/2, mark: player_two_mark()]
        ]
    end
  end
end
