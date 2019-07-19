###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'

def pk_to_pkh( pubkey )
  # ...
end

def checksum( data )
  # ...
end

def base58( data )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_addr
    pubkey = '0250863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b2352'

    pkh = pk_to_pkh( pubkey )
    assert_equal 'f54a5851e9372b87810a8e60cdd2e7cfd80b6e31', pkh

    prefix = '00'    ## version prefix
    h = checksum( prefix + pkh )
    assert_equal 'c7f18fe8fcbed6396741e58ad259b5cb16b7fd7f041904147ba1dcffabf747fd', h
    assert_equal 'c7f18fe8', h[0..7]

    addr = base58( prefix + pkh + h[0..7] )
    assert_equal '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs', addr
  end # method test_addr

end # class RubyQuizTest
