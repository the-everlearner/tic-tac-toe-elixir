defmodule IOTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Marks

  @empty_board List.duplicate(empty_mark(), 9)
  @formatted_empty_board ~s{[ ] [ ] [ ]\n[ ] [ ] [ ]\n[ ] [ ] [ ]\n}

  test "send message to stdout" do
    assert capture_io(fn -> CLI.send_message("dummy message") end) == "dummy message"
  end

  test "format empty board" do
    assert CLI.format_board() == @formatted_empty_board
  end
end
