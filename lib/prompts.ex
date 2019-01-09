defmodule Prompts do
  @welcome_message "Welcome to Tic Tac Toe!"
  def welcome_message, do: @welcome_message

  @ask_tile "Please enter a tile number"
  def ask_tile, do: @ask_tile

  @choice_made_message "Here's the choice!"
  def choice_made_message, do: @choice_made_message

  def win_message(mark), do: ~s{"Player #{mark} won!"}

  def tie_message, do: ~s{"It was a tie..."}
end
