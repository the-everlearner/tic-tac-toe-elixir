defmodule HumanPlayerTest do
  use ExUnit.Case
  import HumanPlayer

  test "converts human choice of tile to correct integer for board" do
    assert convert_choice("7\n") == 6
  end
end
