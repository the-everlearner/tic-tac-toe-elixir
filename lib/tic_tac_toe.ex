defmodule TicTacToe do
  import Board, only: [make_initial_board: 0]
  import Game, only: [run_game: 2]
  import Marks
  import CLI, only: [announce_welcome: 0, get_mode_choice: 0, invalid_mode_message: 0]
  import HumanPlayer, only: [get_tile_from_human: 1]
  import CompPlayer, only: [get_tile_from_comp: 1]
  import Modes

  def run do
    announce_welcome()
    run_game(make_initial_board(), get_players())
  end

  def get_players do
    mode = find_mode()
    make_players(mode)
  end

  def find_mode do
    case get_mode_choice() do
      "1" -> @hvh
      "2" -> @hvc
    end
  end

  def make_players(mode) do
    case mode do
      @hvh ->
        [
          [get_tile: &get_tile_from_human/1, mark: player_one_mark()],
          [get_tile: &get_tile_from_human/1, mark: player_two_mark()]
        ]

      @hvc ->
        [
          [get_tile: &get_tile_from_human/1, mark: player_one_mark()],
          [get_tile: &get_tile_from_comp/1, mark: player_two_mark()]
        ]
    end
  end
end
