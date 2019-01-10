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

  def send_message(message) do
    IO.write(message)
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

  def convert_input_to_integer(input) do
    String.to_integer(remove_line(input))
  end

  def announce_welcome do
  end

  def get_mode_choice do
  end

  def invalid_mode_choice do
  end

  def invalid_mode_message do
  end

  def announce_welcome(board) do
    send_message(welcome_prompt())
    send_message(newline())
    send_message(format_board(board))
    send_message(newline())
  end

  def ask_mode do
    send_message(newline())
    send_message(ask_mode_prompt())
    send_message(newline())
    input = IO.gets("")
    convert_input_to_integer(input)
  end

  def ask_tile_choice do
    send_message(newline())
    send_message(ask_tile_prompt())
    send_message(newline())
    input = IO.gets("")
    convert_input_to_integer(input)
  end

  def turn_end_display(board) do
    send_message(newline())
    send_message(choice_made_prompt())
    send_message(newline())
    send_message(format_board(board))
    send_message(newline())
  end

  def announce_win(mark) do
    send_message(newline())
    send_message(win_prompt(convert_mark(mark)))
    send_message(newline())
  end

  def announce_tie do
    send_message(newline())
    send_message(tie_prompt)
    send_message(newline())
  end

  def add_newlines(phrase) do
    newline() <> phrase <> newline()
  end
end
