# Ruby Quiz - Challenge #2 - Calculate the Bitcoin Genesis Block Hash (SHA-256)


Let's calculate the classic bitcoin (crypto) block hash from scratch (zero).
Let's start with the genesis block, that is block #0
with the unique block hash id `000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f`.

Note: You can search and browse bitcoin blocks using (online)
block explorers. Example:

- [blockchain.info/block/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f](https://blockchain.info/block/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f)
- [blockexplorer.com/block/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f](https://blockexplorer.com/block/000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f)
- and others.


The classic bitcoin (crypto) block hash gets calculated from
the 80-byte block header:

| Field      | Size (Bytes) | Comments           |
|------------|--------------|--------------------|
| version    | 4  byte      | Block version number  |
| prev       | 32 byte      | 256-bit hash of the previous block header |
| merkleroot | 32 byte      |	256-bit hash of all transactions in the block |
| time	     | 4 bytes      | Current timestamp as seconds since 1970-01-01 00:00 |
| bits       | 4 bytes      | Current difficulty target in compact binary format |
| nonce      | 4 bytes      | 32-bit number of the (mined) lucky lottery number used once |

Note: 32 byte x 8 bit = 256 bit

Tip: Find out more about the [Bitcoin Block hashing algorithm](https://en.bitcoin.it/wiki/Block_hashing_algorithm)
in the wiki page.

Using the data for the genesis block the setup is:

``` ruby
version    = 1
prev       = "0000000000000000000000000000000000000000000000000000000000000000"
merkleroot = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
time       = 1231006505
bits       = "1d00ffff"
nonce      = 2083236893
```


The challenge: Code a calculate method that returns the Bitcoin hash. 
Start from scratch or, yes, use any library / gem you can find.

``` ruby
def calculate( version, prev, merkleroot, time, bits, nonce )
  # ...
end
```


To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'


class RubyQuizTest < MiniTest::Test

  def test_calculate

    hash = "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"

    version    = 1
    prev       = "0000000000000000000000000000000000000000000000000000000000000000"
    merkleroot = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
    time       = 1231006505
    bits       = "1d00ffff"
    nonce      = 2083236893
    
    assert_equal hash, calculate( version, prev, merkleroot, time, bits, nonce )

  end # method test_calculate
end # class RubyQuizTest
```

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy hacking and crypto mining with Ruby.

