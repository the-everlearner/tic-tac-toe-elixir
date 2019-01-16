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
- In some cases, it is possible to win on a 4x4 board in a human v comp match on the 8th move - if not won by then, it is not possible to win. All other computer games are unbeatable although the 7th, 8th and 9th moves by the computer may be somewhat slow.

### Notes
- Lower-level tests in the Board module (analysis of winning lines) and the CompPlayer module (minimax algorithm) were deleted as they are now implicitly tested by the top-level functions.
