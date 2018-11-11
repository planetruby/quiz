# Ruby Quiz - Challenge #5 -Crypto Mining - Find the Winning Lucky Number - Nonce (=Number used ONCE) for the Proof-of-Work (PoW) Hash (SHA-256)


Let's find the the winning lucky lumber, that is, nonce (=Number used ONCE)
for the proof-of-work (PoW) hash using SHA-256.



---

Aside:  What's a (Crypto) Hash?

Classic Bitcoin uses the SHA256 hash algorithm. Let's try

```ruby
require 'digest'

Digest::SHA256.hexdigest( 'Hello, Cryptos!' )
```

resulting in

``` ruby
#=> "33eedea60b0662c66c289ceba71863a864cf84b00e10002ca1069bf58f9362d5"
```

Try some more

``` ruby
Digest::SHA256.hexdigest( 'Hello, Cryptos! - Hello, Cryptos! - Hello, Cryptos!' )
#=> "c4b5e2b9685062ecca5d0f6f6ba605b3f99eafed3a3729d2ae1ccaa2b440b1cc"
Digest::SHA256.hexdigest( 'Your Name Here' )
#=> "39459289c09c33a7b516bef926c1873c6ecd2e6db09218b065d7465b6736f801"
Digest::SHA256.hexdigest( 'Data Data Data Data' )
#=> "a7bbfc531b2ecf641b9abcd7ad8e50267e1c873e5a396d1919f504973090565a"
```

Note: The resulting hash is always 256-bit in size
or 64 hex(adecimal) chars (0-9,a-f) in length
even if the input is less than 256-bit or much bigger than 256-bit.


Trivia Quiz: What's SHA256?

- (A) Still Hacking Anyway
- (B) Secure Hash Algorithm
- (C) Sweet Home Austria
- (D) Super High Aperture

B: SHA256 == Secure Hash Algorithms 256 Bits

SHA256 is a (secure) hashing algorithm designed by the National Security Agency (NSA)
of the United States of America (USA).

Find out more @ [Secure Hash Algorithms (SHA) @ Wikipedia](https://en.wikipedia.org/wiki/Secure_Hash_Algorithms).

---



The challenge: Code a `compute_nonce` method that passes the RubyQuizTest :-), that is,
the hash for the nonce plus the data
must start with four leading zeros (`0000`), that is, the "hard-coded" proof-of-work difficulty in the test:


``` ruby
hash = Digest::SHA256.hexdigest( "#{nonce}#{data}" )
## e.g. hash = "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"
assert hash.start_with?( "0000" )
```

Note: `data` is a (random) string e.g. `"Hello, Crypto! The epoch time is now >1541927781<."`
and `compute_nonce` is expected to return
the nonce (=Number used ONCE) as an integer number e.g. `26762` or `68419` etc.

``` ruby
def compute_nonce( data )
  # ...
end
```

Start from scratch or, yes, use any library / gem you can find.

To qualify for solving the code challenge / puzzle you must pass the test:

```ruby
require 'minitest/autorun'
require 'digest'

class RubyQuizTest < MiniTest::Test

  def test_hash_with_proof_of_work
    data  = "Hello, Crypto! The epoch time is now >#{Time.now.to_i}<."

    nonce = compute_nonce( data )
    hash = Digest::SHA256.hexdigest( "#{nonce}#{data}" )

    ## difficulty '0000' - four leading zeros (minimum) in hash
    assert_equal '0000', hash[0..3]
    assert hash.start_with?( '0000' )
  end # method hash_with_proof_of_work
end # class RubyQuizTest
```


Note: The test data for `compute_nonce` is "random", that is,
always changes with every test run (e.g. includes
Epoch time that is, seconds since January 1st, 1970).


---
Aside: What's the mining / proof-of-work difficulty? What's `0000`?

In classic bitcoin you have to compute a hash
that starts with leading zeros (`00`). The more leading zeros the harder (more difficult) to compute. Let's keep it easy to compute and let's start with two leading zeros (`00`), that is, 16^2 = 256 possibilities (^1,2).
Three leading zeros (`000`) would be 16^3 = 4 096 possibilities
and four zeros (`0000`) would be 16^4 = 65 536 and so on.

(1): 16 possibilities because it's a hex or hexadecimal or base 16 number, that is, `0` `1` `2` `3` `4` `5` `6` `7` `8` `9` `a` (10) `b` (11) `c` (12) `d` (13) `e` (14) `f` (15).

(2): A random secure hash algorithm needs on average 256 tries (might be lets say 305 tries, for example, because it's NOT a perfect statistic distribution of possibilities).

---


Happy crypto mining and hashing with ruby.
