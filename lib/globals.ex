defmodule Globals do
  @newline "\r\n"
  def newline, do: @newline

  def remove_line(input) do
    String.replace_suffix(input, "\n", "")
  end

  def valid_number?(input) do
    Regex.match?(~r{^\d+$}, input)
  end
end
