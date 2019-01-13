defmodule TicTacToe do
  import Board, only: [make_initial_board: 1]
  import Game, only: [run_game: 2]
  import Marks

  import CLI,
    only: [
      announce_welcome: 0,
      get_mode_choice: 0,
      invalid_mode_choice: 0,
      announce_goodbye: 0,
      ask_replay: 0,
      ask_grid_size: 0,
      invalid_grid_size_choice: 0
    ]

  import HumanPlayer, only: [make_human_move: 2]
  import CompPlayer, only: [make_comp_move: 2]

  @possible_board_sizes [3, 4]

  @h :h
  @c :c

  @yes :yes
  @no :no

  def run do
    announce_welcome()
    run_game(get_board(), get_players())
    replay?()
  end

  def replay? do
    if find_replay_choice(ask_replay()) == @yes do
      run()
    else
      announce_goodbye()
    end
  end

  def get_board do
    grid_size_choice = ask_grid_size()

    if Enum.member?(@possible_board_sizes, grid_size_choice) do
      make_initial_board(grid_size_choice)
    else
      invalid_grid_size_choice()
      get_board()
    end
  end

  def get_players do
    case get_mode_choice() do
      1 ->
        players_template(@h, @h)

      2 ->
        players_template(@h, @c)

      3 ->
        players_template(@c, @h)

      4 ->
        players_template(@c, @c)

      _ ->
        invalid_mode_choice()
        get_players()
    end
  end

  def players_template(type_one, type_two) do
    [
      [make_move: find_tile_fun(type_one), mark: player_one_mark()],
      [make_move: find_tile_fun(type_two), mark: player_two_mark()]
    ]
  end

  def find_tile_fun(type) do
    if type == @h do
      &make_human_move/2
    else
      &make_comp_move/2
    end
  end

  def find_replay_choice(choice) do
    if choice == "y" do
      @yes
    else
      @no
    end
  end
end
