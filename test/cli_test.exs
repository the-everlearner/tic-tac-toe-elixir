defmodule CLITest do
  use ExUnit.Case
  import CLI
  import Marks
  import IO.ANSI

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

  test "sends yes or no" do
    assert send_yes_or_no("y") == :yes
    assert send_yes_or_no("n") == :no
  end
end
