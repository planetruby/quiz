require 'minitest/autorun'



#
# An entry using Array#pack and Digest
#  by  Frank J. Cameron
#    see https://rubytalk.org/t/re-ruby-quiz-challenge-2-calculate-the-bitcoin-genesis-block-hash-sha-256/74810

module Frank

require 'digest'

def calculate(v, p, m, t, b, n)
    Digest::SHA256.digest(
      Digest::SHA256.digest(
        [v].pack('V') +
        [p].pack('H*').reverse +
        [m].pack('H*').reverse +
        [t].pack('V') +
        [b].pack('H*').reverse +
        [n].pack('V')
      )
    ).reverse.unpack('H*')[0]
end
end # module Frank




class RubyQuizTest < MiniTest::Test

  def hash
    "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f"
  end

  def block_header
    version    = 1
    prev       = "0000000000000000000000000000000000000000000000000000000000000000"
    merkleroot = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
    time       = 1231006505
    bits       = "1d00ffff"
    nonce      = 2083236893

    [version, prev, merkleroot, time, bits,nonce]
  end # method test_calculate
end # class RubyQuizTest




class FrankTest < RubyQuizTest
  include Frank

  def test_calculate
    assert_equal hash, calculate( *block_header )
  end
end
