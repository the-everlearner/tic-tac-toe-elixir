defmodule CLI do
  import Prompts
  import Board, only: [dimension: 1]

  @newline "\r\n"

  def format_board(board) do
    Enum.map(Enum.with_index(board), &get_representation/1)
    |> insert_newlines
    |> List.to_string()
  end

  def announce_welcome do
    clear_screen()
    write_with_newlines(welcome_prompt())
    Process.sleep(1000)
    clear_screen()
  end

  def ask_grid_size do
    grid_size_choice = ask_for_input(ask_grid_size_prompt())

    if valid_number?(grid_size_choice) do
      clear_screen()
      clean_number(grid_size_choice)
    else
      clear_screen()
      write_with_newlines(invalid_number_prompt())
      ask_grid_size()
    end
  end

  def invalid_grid_size_choice do
    clear_screen()
    write_with_newlines(invalid_grid_size_prompt())
  end

  def get_mode_choice do
    mode_choice = ask_for_input(ask_mode_prompt())

    if valid_number?(mode_choice) do
      clear_screen()
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
    Process.sleep(1000)
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

  def display_turn(board) do
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
      send_yes_or_no(clean_y_or_n(replay_choice))
    else
      clear_screen()
      write_with_newlines(invalid_y_or_n_prompt())
      ask_replay()
    end
  end

  def send_yes_or_no(input) do
    if input == "y" do
      :yes
    else
      :no
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

  defp get_representation(tile_with_number) do
    converted_mark = convert_mark(elem(tile_with_number, 0))

    if converted_mark != :empty_mark do
      ~s{[#{converted_mark}]  }
    else
      format_number_tile(elem(tile_with_number, 1) + 1)
    end
  end

  defp format_number_tile(number) do
    if number > 9 do
      ~s{[#{number}] }
    else
      ~s{[#{number}]  }
    end
  end

  defp insert_newlines(converted_tiles) do
    Enum.chunk_every(converted_tiles, dimension(converted_tiles))
    |> Enum.intersperse(@newline)
    |> List.flatten()
  end
end
