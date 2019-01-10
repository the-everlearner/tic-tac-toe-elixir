defmodule GlobalsTest do
  use ExUnit.Case
  import Globals

  test "removes return at end of String" do
    assert remove_line("hello\n") == "hello"
  end

  test "returns true if number valid" do
    assert valid_number?("0") == true
  end
  test "returns false if number not valid" do
    refute valid_number?("0a")
    refute valid_number?("?2")
    refute valid_number?("")
  end
end
