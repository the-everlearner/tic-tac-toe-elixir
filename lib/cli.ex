defmodule CLI do
  import Prompts
  import Marks
  import Globals, only: [newline: 0, remove_line: 1]

  defp convert_mark(mark) do
    case mark do
      :empty_mark -> :empty_mark
      :player_one_mark -> "X"
      :player_two_mark -> "O"
    end
  end

  def format_board(tiles) do
    tile_indices = 1..Enum.count(tiles)
    converted_tiles = Enum.map(tiles, fn tile -> convert_mark(tile) end)
    tiles_to_indices = Enum.zip(converted_tiles, tile_indices)

    formatted_tiles =
      Enum.map(tiles_to_indices, fn tile_and_index ->
        if elem(tile_and_index, 0) == :empty_mark do
          elem(tile_and_index, 1)
        else
          elem(tile_and_index, 0)
        end
      end)

    square_bracks = Enum.map(formatted_tiles, fn tile -> ~s{[#{tile}] } end)
    with_newlines = square_bracks |> List.insert_at(3, newline()) |> List.insert_at(7, newline())
    ~s{#{List.to_string(with_newlines)}#{newline()}}
  end

  def announce_welcome do
    write_with_newlines(welcome_prompt())
  end

  def get_mode_choice do
  end

  def invalid_mode_choice do
  end

  def invalid_mode_message do
  end

  def introduce_game(board) do
    write_with_newlines(introduce_game_prompt)
    write_with_newlines(format_board(board))
  end

  def ask_mode do
    write_with_newlines(ask_mode_prompt())
    input = IO.gets("")
  end

  def ask_tile_choice do
    write_with_newlines(ask_tile_prompt())
    input = IO.gets("")
  end

  def turn_end_display(board) do
    write_with_newlines(choice_made_prompt())
    write_with_newlines(format_board(board))
  end

  def announce_win(mark) do
    write_with_newlines(win_prompt(convert_mark(mark)))
  end

  def announce_tie do
    write_with_newlines(tie_prompt)
  end

  def write_with_newlines(phrase) do
    IO.write(newline() <> phrase <> newline())
  end
end
