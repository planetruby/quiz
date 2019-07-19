# Ruby Quiz - Challenge #15 - Generate the Bitcoin (Base58) Address from the (Elliptic Curve) Public Key


Let's generate the classic bitcoin base58 address
from an (elliptic curve) public key.

Let's follow the steps from
the Bitcoin Wiki article
titled ["How to create Bitcoin Address"](https://en.bitcoin.it/wiki/Technical_background_of_version_1_Bitcoin_addresses#How_to_create_Bitcoin_Address):


![](i/bitcoin-pubkey-to-addr.png)



Step 0 - Having a private Elliptic Curve Digital Signature Algorith (ECDSA) key

    18e14a7b6a307f426a94f8114701e7c8e774e7f9a47e2c2035db29a206321725

Step 1 - Take the corresponding public key generated with it (33 bytes, 1 byte 0x02 (y-coord is even), and 32 bytes corresponding to X coordinate)

    0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352

Step 2 - Perform SHA-256 hashing on the public key

    0b7c28c9b7290c98d7438e70b3d3f7c848fbd7d1dc194ff83f4f7cc9b1378e98

Step 3 - Perform RIPEMD-160 hashing on the result of SHA-256

    f54a5851e9372b87810a8e60cdd2e7cfd80b6e31

Step 4 - Add version byte in front of RIPEMD-160 hash (0x00 for Main Network)

    00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31

Step 5 - Perform SHA-256 hash on the extended RIPEMD-160 result

    ad3c854da227c7e99c4abfad4ea41d71311160df2e415e713318c70d67c6b41c

Step 6 - Perform SHA-256 hash on the result of the previous SHA-256 hash

    c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd

Step 7 - Take the first 4 bytes of the second SHA-256 hash. This is the address checksum

    c7f18fe8

Step 8 - Add the 4 checksum bytes from stage 7 at the end of extended RIPEMD-160 hash from stage 4. This is the 25-byte binary Bitcoin Address.

    00f54a5851e9372b87810a8e60cdd2e7cfd80b6e31c7f18fe8

Step 9 - Convert the result from a byte string into a base58 string using Base58Check encoding. This is the most commonly used Bitcoin Address format

    1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs


That's it.



The challenge: Code a
`pk_to_pkh` (public key to public key hash),
a `checksum` and  a `base58`
method that together return the classic Bitcoin address.
Start from scratch or, yes, use any library / gem you can find.


``` ruby
def pk_to_pkh( pubkey )
  # ...
end

def checksum( data )
  # ...
end

def base58( data )
  # ...
end
```


To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'


class RubyQuizTest < MiniTest::Test

  def test_addr
    pubkey = '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352'

    pkh = pk_to_pkh( pubkey )
    assert_equal 'f54a5851e9372b87810a8e60cdd2e7cfd80b6e31', pkh

    prefix = "00"    ## version prefix
    h = checksum( prefix + pkh )
    assert_equal 'c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd', h
    assert_equal 'c7f18fe8', h[0..7]

    addr = base58( prefix + pkh + h[0..7] )
    assert_equal '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs', addr
  end # method test_addr
end # class RubyQuizTest
```

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy hacking and crypto hashing with Ruby.
