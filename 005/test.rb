# encoding: utf-8

###
## note: use ruby ./test.rb to run test



require 'minitest/autorun'
require 'digest'



def compute_nonce( data )
  # note:  data is a string e.g. "Hello, Crypto! The time is now >1541927781<."
  # ...
  #  returns nonce (=Number used ONCE) as integer e.g. 26762 or 68419 etc.
end




class RubyQuizTest < MiniTest::Test

  def test_hash_with_proof_of_work
    data  = "Hello, Crypto! The time is now >#{Time.now.to_i}<."

    nonce = compute_nonce( data )
    hash = Digest::SHA256.hexdigest( "#{nonce}#{data}" )

    ## difficulty '0000' - four leading zeros (minimum) in hash
    assert_equal '0000', hash[0..3]
    assert hash.start_with?( '0000' )
  end # method hash_with_proof_of_work
end # class RubyQuizTest
