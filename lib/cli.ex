defmodule CLI do
  import Marks

  def send_message(message) do
    IO.write(message)
  end

  def format_board(tiles) do
    ~s{[ ] [ ] [ ]\n[ ] [ ] [ ]\n[ ] [ ] [ ]\n}
  end
end
