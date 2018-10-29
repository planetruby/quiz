###
## note: use ruby ./test.rb to run test 



require 'minitest/autorun'


def calculate( version, prev, merkleroot, time, bits, nonce )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_calculate

    hash = "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"

    version    = 1
    prev       = '0000000000000000000000000000000000000000000000000000000000000000'
    merkleroot = '4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b'
    time       = 1231006505
    bits       = '1d00ffff'
    nonce      = 2083236893
    
    assert_equal hash, calculate( version, prev, merkleroot, time, bits, nonce )

  end # method test_calculate
end # class RubyQuizTest
