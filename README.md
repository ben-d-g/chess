# chess

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Usage](#usage)
- [Gameplay Instructions](#gameplay-instructions)

## Introduction
Command-Line Chess is a Ruby program that allows you to play a game of chess directly in your terminal. Whether you're a seasoned player or just learning, this simple yet powerful tool provides an easy way to practice and enjoy chess without the need for a graphical interface.

## Features
- **Play Chess:** Full chess game implementation, including all standard rules (castling, en passant, pawn promotion, etc.).
- **Command-Line Interface:** Simple, text-based interface for inputting moves and viewing the board.
- **Two-Player Mode:** Play against a friend in a local multiplayer mode.
- **Move Validation:** Automatic validation of moves to ensure they follow the rules of chess.
- **Move History:** Track and display the history of moves made during the game.
- **Check and Checkmate Detection:** Automatically detect check and checkmate conditions.

## Usage
Once the program is running, you can start playing chess by following the on-screen prompts. The program will display the chessboard in a text format, and you'll be able to enter your moves using standard chess notation (e.g., `e2 e4` to move a piece from e2 to e4).

### Commands
- **Enter a move:** Simply type the move you want to make (e.g., `e2 e4`).
- **Resign:** Type `resign` to forfeit the game.
- **Draw:** Type `draw` to offer a draw to your opponent.
- **Help:** Type `help` to display a list of commands and their usage.

## Gameplay Instructions
1. **Start a New Game:** Upon starting the program, you can begin a new chess game.
2. **Make a Move:** Players alternate turns, inputting their moves in algebraic notation.
3. **Win Condition:** The game will automatically detect checkmate and declare the winner. If a stalemate or draw occurs, the game will also recognize this.
