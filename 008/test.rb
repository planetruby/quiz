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
[0x00005ad2b318e6724ce4b9290146531884721ad18c63298a5308a55ad6b6b58d,
"ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede"], ## kitty #1
[0x00004ad083188630c264a1280146021884618c818c6331ca728c425ad6b5b18e,
"ac99 7757 7427 a9a9 1641 5755 d779 4444 7868 6433 cccc cddf"], ## kitty #100
[0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce,
"aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"], ## kitty #1001
[0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac,
"9ca9 8557 a22f gffa 1444 5557 9f77 277b 6778 6348 9afg eded"], ## kitty #1111
[0x00007918c42de87a96b49c8712d687bc6310cc223d6c081ee6a1ac50d8c3184f,
"g5dd 9cg9 gbcc a858 3cc9 gg44 3473 5gcd 21gf e9ed b4dd 773g"], ## kitty #1000001 
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
