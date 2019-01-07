defmodule CLI do
  import Prompts

  @newline "\r\n"

  def send_message(message) do
    IO.write(message)
  end

  def format_board do
    ~s{[ ] [ ] [ ]\n[ ] [ ] [ ]\n[ ] [ ] [ ]\n}
  end

  def initial_prompt do
    send_message(welcome())
    send_message(@newline)
    send_message(format_board())
  end
end
