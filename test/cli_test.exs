defmodule IOTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "send message to stdout" do
    assert capture_io(fn -> CLI.send_message("dummy message") end) == "dummy message"
  end
end
