defmodule CLITest do
  use ExUnit.Case
  import CLI
  import Marks

  @empty_3x3 List.duplicate(empty_mark(), 9)
  @empty_4x4 List.duplicate(empty_mark(), 16)

  test "format empty board" do
    assert format_board(@empty_3x3) == formatted_empty_3x3()
    assert format_board(@empty_4x4) == formatted_empty_4x4()
  end

  test "format marked board" do
    assert format_board(marked_board_1()) == formatted_marked_3x3_1()
    assert format_board(marked_board_2()) == formatted_marked_3x3_2()
  end

  test "cleans number" do
    assert clean_number("0\n") == 0
  end

  test "returns true if number valid" do
    assert valid_number?("0") == true
  end

  test "returns false if number not valid" do
    refute valid_number?("0a")
    refute valid_number?("?2")
    refute valid_number?("")
  end

  test "valid y or no input" do
    assert valid_y_or_n?("y\n") == true
    assert valid_y_or_n?("Y\n") == true
    assert valid_y_or_n?("n\n") == true
    assert valid_y_or_n?("N\n") == true
    refute valid_y_or_n?("no\n")
    refute valid_y_or_n?("")
  end

  def marked_board_1 do
    @empty_3x3 |> List.replace_at(2, player_one_mark()) |> List.replace_at(4, player_two_mark())
  end

  def marked_board_2 do
    @empty_3x3
    |> List.replace_at(3, player_two_mark())
    |> List.replace_at(4, player_one_mark())
    |> List.replace_at(5, player_one_mark())
    |> List.replace_at(8, player_two_mark())
  end

  def formatted_empty_3x3 do
    ~s{[1]  [2]  [3]  \r\n[4]  [5]  [6]  \r\n[7]  [8]  [9]  }
  end

  def formatted_empty_4x4 do
    ~s{[1]  [2]  [3]  [4]  \r\n[5]  [6]  [7]  [8]  \r\n[9]  [10] [11] [12] \r\n[13] [14] [15] [16] }
  end

  def formatted_marked_3x3_1 do
    ~s{[1]  [2]  [X]  \r\n[4]  [O]  [6]  \r\n[7]  [8]  [9]  }
  end

  def formatted_marked_3x3_2 do
    ~s{[1]  [2]  [3]  \r\n[O]  [X]  [X]  \r\n[7]  [8]  [O]  }
  end
end
