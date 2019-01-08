defmodule GlobalsTest do
  use ExUnit.Case
  import Globals

  test "removes return at end of String" do
    assert remove_line("hello\n") == "hello"
  end
end
