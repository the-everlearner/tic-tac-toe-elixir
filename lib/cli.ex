defmodule CLI do
  import Prompts

  @newline "\r\n"

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
    with_newlines = square_bracks |> List.insert_at(3, @newline) |> List.insert_at(7, @newline)
    ~s{#{List.to_string(with_newlines)}#{@newline}}
  end

  def announce_welcome do
    clear_screen()
    write_with_newlines(welcome_prompt())
  end

  def get_mode_choice do
    mode_choice = ask_for_input(ask_mode_prompt())

    if valid_number?(mode_choice) do
      clean_number(mode_choice)
    else
      clear_screen()
      write_with_newlines(invalid_number_prompt())
      get_mode_choice()
    end
  end

  def invalid_mode_choice do
    clear_screen()
    write_with_newlines(invalid_mode_prompt())
  end

  def introduce_game(board) do
    clear_screen()
    write_with_newlines(introduce_game_prompt())
    write_with_newlines(format_board(board))
  end

  def get_tile_choice(board) do
    tile_choice = ask_for_input(ask_tile_prompt())

    if valid_number?(tile_choice) do
      clean_number(tile_choice)
    else
      message_with_board(invalid_number_prompt(), board)
      get_tile_choice(board)
    end
  end

  def tile_not_in_range_message(board) do
    message_with_board(tile_not_in_range_prompt(), board)
  end

  def tile_occupied_message(board) do
    message_with_board(tile_occupied_prompt(), board)
  end

  defp message_with_board(message, board) do
    clear_screen()
    write_with_newlines(message)
    write_with_newlines(format_board(board))
  end

  def turn_end_display(board) do
    message_with_board(choice_made_prompt(), board)
    Process.sleep(1000)
  end

  def announce_win(mark) do
    write_with_newlines(win_prompt(convert_mark(mark)))
  end

  def announce_tie do
    write_with_newlines(tie_prompt())
  end

  def ask_replay do
    replay_choice = ask_for_input(ask_replay_prompt())

    if valid_y_or_n?(replay_choice) do
      clean_y_or_n(replay_choice)
    else
      clear_screen()
      write_with_newlines(invalid_y_or_n_prompt())
      ask_replay()
    end
  end

  def announce_goodbye do
    write_with_newlines(goodbye_prompt())
  end

  defp write_with_newlines(phrase) do
    IO.write(@newline <> phrase <> @newline)
  end

  def clean_number(number) do
    String.to_integer(String.trim(number))
  end

  defp ask_for_input(message) do
    write_with_newlines(message)
    IO.gets("")
  end

  def clear_screen do
    IO.write(IO.ANSI.clear())
  end

  defp convert_mark(mark) do
    case mark do
      :empty_mark -> :empty_mark
      :player_one_mark -> "X"
      :player_two_mark -> "O"
    end
  end

  def valid_y_or_n?(input) do
    cleaned_input = clean_y_or_n(input)
    cleaned_input == "n" || cleaned_input == "y"
  end

  def clean_y_or_n(input) do
    String.downcase(String.trim(input))
  end

  def valid_number?(input) do
    Regex.match?(~r{^\d+$}, input)
  end
end
