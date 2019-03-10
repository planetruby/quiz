# (Secure) Ruby Quiz - Challenge #13 - Create a PonzICO Investment Contract - Blockchain Performance Art

> PonzICO is an impressive piece of engineering.
>
> --Wayne Chain

> The great art project of our age is to entirely collapse the distinctions between "fraud"
> and "performance art," so that one day mortgage-bond traders will be able to say
> "wait, no, I wasn't lying about bond prices to increase my bonus, I was performing
> a metafictional narrative about bond-price negotiations in order to problematize
> the underlying foundations of bond trading in late capitalism."
>
> -- Matt Levine

> After you invest, vote on the color of my Tesla.
>
> -- Josh Cincinnati, PonzICO Founder

Let's use the live
and "real world" blockchain performance art
PonzICO investment contract running on the Ethereum world computer.

Read the [PonzICO White Paper](https://ponzico.win) for how the investment scheme and dividend payouts work
and what your money will get used for (hint: thanks for the free Tesla - don't forget to vote on the color :-) - and
maybe a two bedroom condo in San Francisco).

> PonzICO is the first ICO to respect your intelligence by calling a spade a spade.
> Here's how it differs from your everyday ICO:
>
> - It dispense with tokens entirely - we all want that sweet, sweet ether.
> - There is no limited time window for "investment." Time is an illusion.
> - PonzICO also dispenses with the notion that it needs a meaningful product
>   attached to its future earning potential. It is the product.
> - All profits from PonzICO are carried in balances linked to prior participants
>   in proportion to their prior investment on a transaction by transaction basis...
>   with a trivial, 50% service fee for yours truly, as nominal recompense for spending
>   a solid couple of days re-learning LaTeX and Solidity.
>
>
> That's it. With every new transaction into the PonzICO `invest` method,
> PonzICO immediately balances that ETH to prior participants based on their current
> proportion of ownership (minus my extremely minor, entirely fair 50% service fee).
> Upon updating the balances, the new participant is added to the list to receive future
> disbursements, and PonzICO dilutes everyone else’s stake accordingly. When they
> are ready to receive their balance, they simply use the `withdraw` method.
> Preexisting holders can always put more ETH into PonzICO to reduce their dilution -
> especially with the convenient `reinvest` method - at the cost of that transaction
> being disbursed to current stakeholders.
>
> -- Josh Cincinnati, PonzICO White Paper


The challenge: Code a contract for the PonzICO investment scheme using sruby :-).

Here's the code in the JavaScript-like Solidity "world standard" in its full glory:

``` solidity
contract PonzICO {
    address public owner;
    uint public total;
    mapping (address => uint) public invested;
    mapping (address => uint) public balances;
    address[] investors;

    //log event of successful investment/withdraw and address
    event Investment(address investor, uint amount);
    event Withdrawal(address investor, uint amount);

    // constructor for initializing PonzICO.
    // the owner is the genius who made this revolutionary smart contract
    constructor() public {
	owner = msg.sender;
    }

    // the logic for a small fee for the creator of this contract
    // miniscule in the grand scheme of things
    function ownerFee(uint amount) private returns (uint fee) {
        if (total < 200000 ether) {
            fee = amount/2;
            balances[owner] += fee;
        }
        return;
    }

    // This is where the magic is withdrawn.
    // For users with balances. Can only be used to withdraw full balance.
    function withdraw()
    {
        require( balances[msg.sender] > 0 );

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        if (!msg.sender.send(amount)) {
            balances[msg.sender] = amount;
        } else {
            emit Withdrawal(msg.sender, amount);
        }
    }

    // What's better than withdrawing? Re-investing profits!
    function reinvest()
    {
        require( balances[msg.sender] > 0 );

        uint dividend = balances[msg.sender];
        balances[msg.sender] = 0;
        uint fee = ownerFee(dividend);
        dividend -= fee;
        for (uint i = 0; i < investors.length; i++) {
            balances[investors[i]] += dividend * invested[investors[i]] / total;
        }
        invested[msg.sender] += (dividend + fee);
        total += (dividend + fee);
        emit Investment(msg.sender, dividend+fee);
    }

    // This is the where the magic is invested.
    // Note the accreditedInvestor() modifier, to ensure only sophisticated
    // investors with 0.1 ETH or more can invest. #SelfRegulation
    function invest() payable
    {
        require( msg.value > 100 finney );

        // first send the owner's modest 50% fee but only if the total invested is less than 200000 ETH
        uint dividend = msg.value;
        uint fee = ownerFee(dividend);
        dividend -= fee;
        // then accrue balances from the generous remainder to everyone else previously invested
        for (uint i = 0; i < investors.length; i++) {
            balances[investors[i]] += dividend * invested[investors[i]] / total;
        }

        // finally, add this enterprising new investor to the public balances
        if (invested[msg.sender] == 0) {
            investors.push(msg.sender);
            invested[msg.sender] = msg.value;
        } else {
            invested[msg.sender] += msg.value;
        }
        total += msg.value;
        emit Investment(msg.sender, msg.value);
	}

    // finally, fallback function. no one should send money to this contract
    // without first being added as an investment.
    function () { throw; }
}
```

(Source: [`etherscan.io/address/0x1ce7986760ade2bf0f322f5ef39ce0de3bd0c82b/#code`](https://etherscan.io/address/0x1ce7986760ade2bf0f322f5ef39ce0de3bd0c82b/#code))


Can you do better?

Post your code snippets (or questions or comments) on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy hacking and (crypto) blockchain contract scripting with sruby.



## Bonus Level - Vote On My Tesla Color

Up for a bonus level?  Turn the "Vote On My Tesla Color" contract into sruby too :-).

``` solidity
contract VoteOnMyTeslaColor {
    address public owner;
    enum Color { SolidBlack, MidnightSilverMetallic, DeepBlueMetallic, SilverMetallic, RedMultiCoat }
    mapping (uint8 => uint32) public votes;
    mapping (address => bool) public voted;

    event Votes(Color color, uint num);
    event Winner(Color color);

    // hardcode production PonzICO address
    PonzICO ponzico = PonzICO(0x1ce7986760ADe2BF0F322f5EF39Ce0DE3bd0C82B);

    // constructor for initializing VoteOnMyTeslaColor
    // the owner is the genius who made the revolutionary smart contract PonzICO
    // obviously blue starts with 10 votes because it is objectively the BEST color
    constructor() public {
        owner = msg.sender;
        // YOURE MY BOY BLUE
        votes[uint8(2)] = 10;
    }

    // SUPER ACCREDITED INVESTORS ONLY, YOU CAN ONLY VOTE ONCE
    function vote(uint8 color)
    {
        require( ponzico.invested(msg.sender) >= 0.1 ether && !voted[msg.sender] );
        require( color < uint8(5) );

        // 0.1 ETH invested in PonzICO per vote, truncated
        uint32 num = uint32(ponzico.invested(msg.sender) / (0.1 ether));
        votes[color] += num;
        voted[msg.sender] = true;
        emit Votes(Color(color), num);
    }

    // pay to vote again! I don't care!
    // ...but it'll cost you 1 ether for me to look the other way, wink wink
    function itsLikeChicago() payable {
        require( voted[msg.sender] && msg.value >= 1 ether );
        voted[msg.sender] = false;
    }

    function winnovate()
    {
        require( msg.sender == owner );

        Color winner = Color.SolidBlack;
        for (uint8 choice = 1; choice < 5; choice++) {
            if (votes[choice] > votes[choice-1]) {
                winner = Color(choice);
            }
        }
        emit Winner(winner);
        // keeping dat blockchain bloat on check
        selfdestruct(owner);
    }
}
```

(Source: [`etherscan.io/address/0x75f97d98eb49989f9af40c49a7a1eb32767214f5/#code`](https://etherscan.io/address/0x75f97d98eb49989f9af40c49a7a1eb32767214f5/#code))
