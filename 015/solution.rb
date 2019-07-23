require 'minitest/autorun'


#
# Test entry
#   by Gerald Bauer

module TestAnswer

require 'digest'

module Base58
  ALPHABET = %w[
        1 2 3 4 5 6 7 8 9
      A B C D E F G H   J K L M N   P Q R S T U V W X Y Z
      a b c d e f g h i j k   m n o p q r s t u v w x y z
  ]
  BASE = 58   # note: ALPHABET.length == 58

  def self.encode( hex )
    num = hex.to_i(16)

    buf = String.new
    while num > 0
      remainder = num % BASE
      buf = ALPHABET[remainder] + buf
      num = num / BASE
    end

    # Note: Leading zeros (in bytes, that is, 00 in hex)
    ##      need to get preserved and added up front (0 in base58 is 1)
    leading_zero_bytes = (hex.match( /^(0+)/ ) ? $1 : '').size / 2

    (ALPHABET[0]*leading_zero_bytes) + buf
  end
end  # module Base58


def base58( hex ) Base58.encode( hex ); end


def hash160( pubkey )
  binary    = [pubkey].pack( "H*" )       # Convert to binary (string) first before hashing
  sha256    = Digest::SHA256.digest( binary )
  ripemd160 = Digest::RMD160.digest( sha256 )
              ripemd160.unpack( "H*" )[0]    # Convert back to hex (string) from binary (string)
end

def hash256( hex )
  binary = [hex].pack( "H*" )       # Convert to binary (string) first before hashing
  step1  = Digest::SHA256.digest( binary )
  step2  = Digest::SHA256.digest( step1 )
           step2.unpack( "H*" )[0]    # Convert back to hex (string) from binary (string)
end
end



class RubyQuizTest < MiniTest::Test

  def assert_addr
     pubkey = '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352'

     pkh    = hash160( pubkey )
     assert_equal 'f54a5851e9372b87810a8e60cdd2e7cfd80b6e31', pkh

     prefix = '00'    ## version prefix for pay-to-public-key-hash (p2pkh) transaction
     h      = hash256( prefix + pkh )
     assert_equal 'c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd', h
     assert_equal 'c7f18fe8', h[0..7]

     addr   = base58( prefix + pkh + h[0..7] )
     assert_equal '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs', addr
   end # method test_addr

end # class RubyQuizTest



class TestAnswerTest < RubyQuizTest
  include TestAnswer

  def test_addr() assert_addr; end
end
