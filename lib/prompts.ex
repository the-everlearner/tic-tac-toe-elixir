defmodule Prompts do
  @welcome_message "Welcome to Tic Tac Toe!"
  def welcome_message, do: @welcome_message

  @ask_tile "Please enter a tile number"
  def ask_tile, do: @ask_tile

  @choice_made_message "And here's the choice"
  def choice_made_message, do: @choice_made_message
end
