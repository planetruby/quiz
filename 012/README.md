
# (Secure) Ruby Quiz - Challenge #12 - Create a 3x3 Tic-Tac-Toe Player vs Player Game Contract

Let's use the "[Creating a Tic-Tac-Toe Smart Contract](https://developers.eos.io/eosio-cpp/v1.3.1/docs/tic-tac-toe-tutorial)" tutorial
and sample contract from the EOS.IO blockchain.

The challenge:
Code a contract for a 3x3 tic-tac-toe player vs player game
using sruby :-).


Here's the EOS.IO C++ "monster" in its full glory:

``` cpp

#include <eosiolib/eosio.hpp>

/**
 *  @defgroup tictactoecontract Tic Tac Toe Contract
 *  @brief Defines the PvP tic tac toe contract example
 *  @ingroup examplecontract
 *  
 *  @details
 *  For the following tic-tac-toe game:
 *  - Each pair of player can have 2 unique game, one where player_1 become host and player_2 become challenger and vice versa
 *  - The game data is stored in the "host" scope and use the "challenger" as the key
 *  
 *  (0,0) coordinate is on the top left corner of the board
 *  @code
 *                 (0,2)
 *  (0,0) -  |  o  |  x      where - = empty cell
 *        -  |  x  |  -            x = move by host
 *  (2,0) x  |  o  |  o            o = move by challenger
 *  @endcode
 *
 *  Board is represented with number:
 *  - 0 represents empty cell
 *  - 1 represents cell filled by host
 *  - 2 represents cell filled by challenger
 *  Therefore, assuming x is host, the above board will have the following representation: [0, 2, 1, 0, 1, 0, 1, 2, 2] inside the game object
 *
 *  In order to deploy this contract:
 *  - Create an account called tic.tac.toe
 *  - Add tic.tac.toe key to your wallet
 *  - Set the contract on the tic.tac.toe account
 *
 *  How to play the game:
 *  - Create a game using `create` action, with you as the host and other account as the challenger.
 *  - The first move needs to be done by the host, use the `move` action to make a move by specifying which row and column to fill.
 *  - Then ask the challenger to make a move, after that it's back to the host turn again, repeat until the winner is determined.
 *  - If you want to restart the game, use the `restart` action
 *  - If you want to clear the game from the database to save up some space after the game has ended, use the `close` action
 *  @{
 */

class tic_tac_toe : public eosio::contract {
   public:
      tic_tac_toe( account_name self ):contract(self){}
      /**
       * @brief Information related to a game
       * @abi table games i64
       */
      struct game {
         static const uint16_t board_width = 3;
         static const uint16_t board_height = board_width;
         game() {
            initialize_board();
         }
         account_name          challenger;
         account_name          host;
         account_name          turn; // = account name of host/ challenger
         account_name          winner = N(none); // = none/ draw/ name of host/ name of challenger
         std::vector<uint8_t>  board;

         // Initialize board with empty cell
         void initialize_board() {
            board = std::vector<uint8_t>(board_width * board_height, 0);
         }

         // Reset game
         void reset_game() {
            initialize_board();
            turn = host;
            winner = N(none);
         }

         auto primary_key() const { return challenger; }
         EOSLIB_SERIALIZE( game, (challenger)(host)(turn)(winner)(board))
      };

      /**
       * @brief The table definition, used to store existing games and their current state
       */
      typedef eosio::multi_index< N(games), game> games;

      /// @abi action
      /// Create a new game
      void create(const account_name& challenger, const account_name& host);

      /// @abi action
      /// Restart a game
      /// @param by the account who wants to restart the game
      void restart(const account_name& challenger, const account_name& host, const account_name& by);

      /// @abi action
      /// Close an existing game, and remove it from storage
      void close(const account_name& challenger, const account_name& host);

      /// @abi action
      /// Make movement
      /// @param by the account who wants to make the move
      void move(const account_name& challenger, const account_name& host, const account_name& by, const uint16_t& row, const uint16_t& column);

};
```

(Source: [`EOSIO/eos/contracts/tic_tac_toe/tic_tac_toe.hpp`](https://github.com/EOSIO/eos/blob/master/contracts/tic_tac_toe/tic_tac_toe.hpp))


``` cpp
#include "tic_tac_toe.hpp"

using namespace eosio;

/**
 * @brief Check if cell is empty
 * @param cell - value of the cell (should be either 0, 1, or 2)
 * @return true if cell is empty
 */
bool is_empty_cell(const uint8_t& cell) {
   return cell == 0;
}

/**
 * @brief Check for valid movement
 * @detail Movement is considered valid if it is inside the board and done on empty cell
 * @param row - the row of movement made by the player
 * @param column - the column of movement made by the player
 * @param board - the board on which the movement is being made
 * @return true if movement is valid
 */
bool is_valid_movement(const uint16_t& row, const uint16_t& column, const vector<uint8_t>& board) {
   uint16_t board_width = tic_tac_toe::game::board_width;
   uint16_t board_height = tic_tac_toe::game::board_height;
   uint32_t movement_location = row * board_width + column;
   bool is_valid = column < board_width && row < board_height && is_empty_cell(board[movement_location]);
   return is_valid;
}

/**
 * @brief Get winner of the game
 * @detail Winner of the game is the first player who made three consecutive aligned movement
 * @param current_game - the game which we want to determine the winner of
 * @return winner of the game (can be either none/ draw/ account name of host/ account name of challenger)
 */
account_name get_winner(const tic_tac_toe::game& current_game) {
   auto& board = current_game.board;

   bool is_board_full = true;



   // Use bitwise AND operator to determine the consecutive values of each column, row and diagonal
   // Since 3 == 0b11, 2 == 0b10, 1 = 0b01, 0 = 0b00
   vector<uint32_t> consecutive_column(tic_tac_toe::game::board_width, 3 );
   vector<uint32_t> consecutive_row(tic_tac_toe::game::board_height, 3 );
   uint32_t consecutive_diagonal_backslash = 3;
   uint32_t consecutive_diagonal_slash = 3;
   for (uint32_t i = 0; i < board.size(); i++) {
      is_board_full &= !is_empty_cell(board[i]);
      uint16_t row = uint16_t(i / tic_tac_toe::game::board_width);
      uint16_t column = uint16_t(i % tic_tac_toe::game::board_width);

      // Calculate consecutive row and column value
      consecutive_row[column] = consecutive_row[column] & board[i];
      consecutive_column[row] = consecutive_column[row] & board[i];
      // Calculate consecutive diagonal \ value
      if (row == column) {
         consecutive_diagonal_backslash = consecutive_diagonal_backslash & board[i];
      }
      // Calculate consecutive diagonal / value
      if ( row + column == tic_tac_toe::game::board_width - 1) {
         consecutive_diagonal_slash = consecutive_diagonal_slash & board[i];
      }
   }

   // Inspect the value of all consecutive row, column, and diagonal and determine winner
   vector<uint32_t> aggregate = { consecutive_diagonal_backslash, consecutive_diagonal_slash };
   aggregate.insert(aggregate.end(), consecutive_column.begin(), consecutive_column.end());
   aggregate.insert(aggregate.end(), consecutive_row.begin(), consecutive_row.end());
   for (auto value: aggregate) {
      if (value == 1) {
         return current_game.host;
      } else if (value == 2) {
         return current_game.challenger;
      }
   }
   // Draw if the board is full, otherwise the winner is not determined yet
   return is_board_full ? N(draw) : N(none);
}

/**
 * @brief Apply create action
 */
void tic_tac_toe::create(const account_name& challenger, const account_name& host) {
   require_auth(host);
   eosio_assert(challenger != host, "challenger shouldn't be the same as host");

   // Check if game already exists
   games existing_host_games(_self, host);
   auto itr = existing_host_games.find( challenger );
   eosio_assert(itr == existing_host_games.end(), "game already exists");

   existing_host_games.emplace(host, [&]( auto& g ) {
      g.challenger = challenger;
      g.host = host;
      g.turn = host;
   });
}

/**
 * @brief Apply restart action
 */
void tic_tac_toe::restart(const account_name& challenger, const account_name& host, const account_name& by) {
   require_auth(by);

   // Check if game exists
   games existing_host_games(_self, host);
   auto itr = existing_host_games.find( challenger );
   eosio_assert(itr != existing_host_games.end(), "game doesn't exists");

   // Check if this game belongs to the action sender
   eosio_assert(by == itr->host || by == itr->challenger, "this is not your game!");

   // Reset game
   existing_host_games.modify(itr, itr->host, []( auto& g ) {
      g.reset_game();
   });
}

/**
 * @brief Apply close action
 */
void tic_tac_toe::close(const account_name& challenger, const account_name& host) {
   require_auth(host);

   // Check if game exists
   games existing_host_games(_self, host);
   auto itr = existing_host_games.find( challenger );
   eosio_assert(itr != existing_host_games.end(), "game doesn't exists");

   // Remove game
   existing_host_games.erase(itr);
}

/**
 * @brief Apply move action
 */
void tic_tac_toe::move(const account_name& challenger, const account_name& host, const account_name& by, const uint16_t& row, const uint16_t& column ) {
   require_auth(by);

   // Check if game exists
   games existing_host_games(_self, host);
   auto itr = existing_host_games.find( challenger );
   eosio_assert(itr != existing_host_games.end(), "game doesn't exists");

   // Check if this game hasn't ended yet
   eosio_assert(itr->winner == N(none), "the game has ended!");
   // Check if this game belongs to the action sender
   eosio_assert(by == itr->host || by == itr->challenger, "this is not your game!");
   // Check if this is the  action sender's turn
   eosio_assert(by == itr->turn, "it's not your turn yet!");


   // Check if user makes a valid movement
   eosio_assert(is_valid_movement(row, column, itr->board), "not a valid movement!");

   // Fill the cell, 1 for host, 2 for challenger
   const uint8_t cell_value = itr->turn == itr->host ? 1 : 2;
   const auto turn = itr->turn == itr->host ? itr->challenger : itr->host;
   existing_host_games.modify(itr, itr->host, [&]( auto& g ) {
      g.board[row * tic_tac_toe::game::board_width + column] = cell_value;
      g.turn = turn;
      g.winner = get_winner(g);
   });
}


EOSIO_ABI( tic_tac_toe, (create)(restart)(close)(move))
```

(Source: [`EOSIO/eos/contracts/tic_tac_toe/tic_tac_toe.cpp`](https://github.com/EOSIO/eos/blob/master/contracts/tic_tac_toe/tic_tac_toe.cpp))


Can you do better?

Post your code snippets (or questions or comments) on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy hacking and (crypto) blockchain contract scripting with sruby.
