# (Secure) Ruby Quiz - Challenge #14 - Powerball Mega Millions Grand Prize - Create a Power Play Contract for America's Most Popular Lottery

Let's use America's most popular lottery and make it provable fair by - surprise, surprise -
putting the machinery on the blockchain with a contract script.

First let's warm-up with the simplest possible lottery contract
from the book "[Building Games with Ethereum Smart Contracts](https://www.apress.com/book/9781484234914)"
by Kedar Iyer and Chris Dannen.


``` solidity
contract SimpleLottery {
    uint public constant TICKET_PRICE = 1e16; // 0.01 ether

    address[] public tickets;
    address public winner;
    uint public ticketingCloses;

    constructor(uint duration) public {
        ticketingCloses = now + duration;
    }

    function buy () public payable {
        require(msg.value == TICKET_PRICE);
        require(now < ticketingCloses);

        tickets.push(msg.sender);
    }

    function drawWinner () public {
        require(now > ticketingCloses + 5 minutes);
        require(winner == address(0));

        bytes32 rand = keccak256(
            block.blockhash(block.number-1)
        );
        winner = tickets[uint(rand) % tickets.length];
    }

    function withdraw () public {
        require(msg.sender == winner);
        msg.sender.transfer(this.balance);
    }

    function () payable public {
        buy();
    }
}
```

(Source: [`ethereum-games/contracts/Lotteries.sol`](https://github.com/k26dr/ethereum-games/blob/master/contracts/Lotteries.sol))


The starter level one challenge - code the lottery contract using sruby :-).

Let's move on to the real world and
let's pick America's most popular lottery - Powerball Mega Millions.

Powerball Trivia:  On January 13, 2016, Powerball produced the largest lottery jackpot in history ever; the $1 586 millions (!), that is, $1.586 billion jackpot was split by three tickets sold in Chino Hills, California; in Munford, Tennessee; and in Melbourne Beach, Florida. Congrats! [The Lucky Powerball Numbers were (4) (8) (19) (27) (34) and (10).](https://www.powerball.net/numbers/2016-01-13)

Playing the game:

In each game, players select five numbers from a set of 69 white balls
and one number from 26 red Powerballs;
the red ball number can be the same as one of the white balls.
The drawing order of the five white balls is irrelevant.
Players CANNOT use the drawn Powerball to match white numbers, or vice versa.

In each drawing, winning numbers are selected using two ball machines:
one containing the white balls and the other containing the red Powerballs.
Five white balls are drawn from the first machine and the red ball from the second machine.
Games matching at least three white balls or the red Powerball win.

(Source: [Powerball @ Wikipedia](https://en.wikipedia.org/wiki/Powerball))

And here are the odds and prizes / payouts for a minimum $2 ticket:

| Matches                       | Prize | Odds of winning         |
|-------------------------------|------:|-------------------------|
| 0+1  (Match Powerball Only)   |  $4   | 1 in 38.32 [a] |
| 1+1  (Match 1 + Powerball)    |  $4   | 1 in 91.98 |
| 2+1  (Match 2 + Powerball)    |  $7   | 1 in 701.33 |
| 3+0  (Match 3 Numbers)        |  $7   | 1 in 579.76 |
| 3+1  (Match 3 + Powerball)    | $100  | 1 in 14 494.11 |
| 4+0  (Match 4 Numbers)        | $100  | 1 in 36 525.17  |
| 4+1  (Match 4 + Powerball)    | $50000 |  1 in 913 129.18 |
| 5+0  (Match 5 Numbers)        | $1000000 |  1 in 11 688 053.52 |
| 5+1  (Match 5 + Powerball)    | Mega Million Jackpot / Grand Prize |  1 in 292 201 338 |

Overall odds of winning a prize are 1 in 24.87.

[a]: Odds of winning 0+1 prize are 1:38.32 instead of 1:26 as there is the possibility of also matching at least one white ball.

The challenge let's make the lottery provable fair with a blockchain contract script.

Powerball Trivia: Two identical machines are used for each drawing, randomly selected from four sets. The model of machine used is the Halogen, manufactured by Smartplay International of Edgewater Park, New Jersey. There are eight ball sets (four of each color); one set of each color is randomly selected before a drawing. The balls are mixed by a turntable at the bottom of the machine that propels the balls around the chamber. When the machine selects a ball, the turntable slows to catch it, sends it up the shaft, and then down the rail to the display.

Again let's use the Solidity code
from the book "Building Games with Ethereum Smart Contracts"
by Kedar Iyer and Chris Dannen
as a quick starter:

``` solidity
contract Powerball {
    struct Round {
        uint endTime;
        uint drawBlock;
        uint[6] winningNumbers;
        mapping(address => uint[6][]) tickets;
    }

    uint public constant TICKET_PRICE = 2e15;
    uint public constant MAX_NUMBER = 69;
    uint public constant MAX_POWERBALL_NUMBER = 26;
    uint public constant ROUND_LENGTH = 3 days;

    uint public round;
    mapping(uint => Round) public rounds;

    constructor() public {
        round = 1;
        rounds[round].endTime = now + ROUND_LENGTH;
    }

    function buy (uint[6][] numbers) payable public {
        require(numbers.length * TICKET_PRICE == msg.value);

        // Ensure the non-powerball numbers on each ticket are unique
        for (uint k=0; k < numbers.length; k++) {
            for (uint i=0; i < 4; i++) {
                for (uint j=i+1; j < 5; j++) {
                    require(numbers[k][i] != numbers[k][j]);
                }
            }
        }

        // Ensure the picked numbers are within the acceptable range
        for (i=0; i < numbers.length; i++) {
            for (j=0; j < 6; j++)
                require(numbers[i][j] > 0);
            for (j=0; j < 5; j++)
                require(numbers[i][j] <= MAX_NUMBER);
            require(numbers[i][5] <= MAX_POWERBALL_NUMBER);
        }

        // check for round expiry
        if (now > rounds[round].endTime) {
            rounds[round].drawBlock = block.number + 5;
            round += 1;
            rounds[round].endTime = now + ROUND_LENGTH;
        }

        for (i=0; i < numbers.length; i++)
            rounds[round].tickets[msg.sender].push(numbers[i]);
    }

    function drawNumbers (uint _round) public {
        uint drawBlock = rounds[_round].drawBlock;
        require(now > rounds[_round].endTime);
        require(block.number >= drawBlock);
        require(rounds[_round].winningNumbers[0] == 0);

        uint i = 0;
        uint seed = 0;
        while (i < 5) {
            bytes32 rand = keccak256(block.blockhash(drawBlock), seed);
            uint numberDraw = uint(rand) % MAX_NUMBER + 1;  

            // non-powerball numbers must be unique
            bool duplicate = false;
            for (uint j=0; j < i; j++) {
                if (numberDraw == rounds[_round].winningNumbers[j]) {
                    duplicate = true;
                    seed++;
                    break;
                }
            }
            if (duplicate)
                continue;

            rounds[_round].winningNumbers[i] = numberDraw;
            i++; seed++;
        }
        rand = keccak256(block.blockhash(drawBlock), seed);
        uint powerballDraw = uint(rand) % MAX_POWERBALL_NUMBER + 1;
        rounds[_round].winningNumbers[5] = powerballDraw;
    }

    function claim (uint _round) public {
        require(rounds[_round].tickets[msg.sender].length > 0);
        require(rounds[_round].winningNumbers[0] != 0);

        uint[6][] storage myNumbers = rounds[_round].tickets[msg.sender];
        uint[6] storage winningNumbers = rounds[_round].winningNumbers;

        uint payout = 0;
        for (uint i=0; i < myNumbers.length; i++) {
            uint numberMatches = 0;
            for (uint j=0; j < 5; j++) {
                for (uint k=0; k < 5; k++) {
                    if (myNumbers[i][j] == winningNumbers[k])
                        numberMatches += 1;
                }
            }
            bool powerballMatches = (myNumbers[i][5] == winningNumbers[5]);

            // win conditions
            if (numberMatches == 5 && powerballMatches) {
                payout = this.balance;
                break;
            }
            else if (numberMatches == 5)
                payout += 1000 ether;
            else if (numberMatches == 4 && powerballMatches)
                payout += 50 ether;
            else if (numberMatches == 4)
                payout += 1e17; // .1 ether
            else if (numberMatches == 3 && powerballMatches)
                payout += 1e17; // .1 ether
            else if (numberMatches == 3)
                payout += 7e15; // .007 ether
            else if (numberMatches == 2 && powerballMatches)
                payout += 7e15; // .007 ether
            else if (powerballMatches)
                payout += 4e15; // .004 ether
        }

        msg.sender.transfer(payout);
        delete rounds[_round].tickets[msg.sender];
    }

    function ticketsFor(uint _round, address user) public view
      returns (uint[6][] tickets) {
        return rounds[_round].tickets[user];
    }

    function winningNumbersFor(uint _round) public view
      returns (uint[6] winningNumbers) {
        return rounds[_round].winningNumbers;
    }
}
```

(Source: [`ethereum-games/contracts/Lotteries.sol`](https://github.com/k26dr/ethereum-games/blob/master/contracts/Lotteries.sol))

Can you do better?

Post your (secure) ruby code snippets (or questions or comments) on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy hacking and (crypto) blockchain contract scripting with sruby.
