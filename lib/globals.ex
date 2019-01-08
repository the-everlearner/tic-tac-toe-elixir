defmodule Globals do
  @newline "\r\n"
  def newline, do: @newline

  def remove_line(input) do
    String.replace_suffix(input, "\n", "")
  end
end
