# encoding: utf-8

###
## note: use ruby ./test.rb to run test



require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test


  def kai_encode( num )
    ## ...
  end

  def kai_fmt( kai )
    ## ...
  end



  #############################
  ## test data
  def genomes
     [
       [0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce,
        "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"]
     ]
  end

  ####################
  ## tests
  def test_kai_encode
    genomes.each do |pair|
      num       = pair[0]
      exp_value = pair[1].gsub(' ', '')   # note: remove spaces

      assert_equal exp_value, kai_encode( num )
    end
  end # method test_kai_encode

  def test_kai_fmt
    genomes.each do |pair|
      kai       = pair[1].gsub(' ', '')   # note: remove spaces
      exp_value = pair[1]

      assert_equal exp_value, kai_fmt( kai )
    end
  end # method test_kai_fmt

end # class RubyQuizTest
