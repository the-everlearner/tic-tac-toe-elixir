# Tic Tac Toe
A command-line Tic Tac Toe game app written in Elixir.

### Setup
1. Install [Elixir](https://elixir-lang.org/install.html)

2. Clone this repo and cd in:
	`$ git clone https://github.com/the-everlearner/tic_tac_toe.git`

	`$ cd tic_tac_toe`

3. Fetch dependencies (enter 'y' to install Hex if required):
	`$ mix deps.get`

4. Test:
	`$ mix test`

### Play
To play from the command line, build the escript then run the generated executable:
	`$ mix escript.build`
	`$ ./tic_tac_toe`

### Features
- Four game modes
- Two board sizes
- Unbeatable computer player (minimax with alpha-beta pruning)

### Known Bugs
- Unbeatable computer player is slow on 4x4 board

### Notes
- Lower-level tests in the Board module (analysis of winning lines) and the CompPlayer module (minimax algorithm) were deleted as they are now implicitly tested by the top-level functions.
