# encoding: utf-8

###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'

def mixgenes( mgenes, sgenes )  ## returns babygenes
  babygenes = []
  # ...
  babygenes
end


class RubyQuizTest < MiniTest::Test

  def test_mixgenes
    mgenes     = [12, 11, 12, 14, 15, 8, 9, 9, 2, 3, 1, 1, 19, 5, 3, 7, 16, 4, 6, 0, 9, 13, 13, 9, 19, 4, 2, 4, 0, 0, 12, 3, 23, 8, 3, 8, 6, 14, 3, 9, 19, 7, 6, 4, 9, 11, 12, 12]
    sgenes     = [9, 9, 11, 14, 23, 15, 8, 14, 3, 7, 6, 5, 3, 19, 6, 6, 4, 6, 3, 5, 6, 6, 14, 8, 2, 4, 7, 2, 0, 0, 12, 0, 15, 15, 8, 10, 6, 14, 14, 6, 5, 4, 4, 5, 20, 9, 8, 11]

    babygenes1 = [9, 9, 11, 14, 23, 8, 9, 14, 3, 3, 5, 1, 3, 19, 3, 7, 16, 4, 6, 5, 9, 6, 14, 8, 19, 4, 2, 4, 0, 0, 12, 3, 23, 15, 8, 10, 6, 14, 3, 9, 19, 5, 6, 5, 20, 9, 11, 8]
    babygenes2 = [12, 9, 11, 11, 15, 23, 9, 9, 5, 2, 3, 6, 3, 19, 5, 6, 4, 4, 3, 5, 9, 6, 13, 9, 19, 4, 7, 4, 0, 0, 12, 12, 15, 3, 8, 10, 6, 3, 14, 9, 19, 5, 5, 4, 9, 9, 11, 8]
    babygenes3 = [12, 12, 14, 11, 15, 23, 8, 14, 3, 1, 3, 1, 19, 3, 7, 6, 16, 5, 6, 3, 6, 6, 13, 9, 19, 4, 2, 4, 0, 0, 0, 12, 23, 3, 8, 8, 6, 6, 14, 14, 4, 19, 6, 7, 9, 12, 9, 11]

    srand( 123 )
    assert_equal babygenes1, mixgenes( mgenes, sgenes )
    assert_equal babygenes2, mixgenes( mgenes, sgenes )
    assert_equal babygenes3, mixgenes( mgenes, sgenes )
  end

end # class RubyQuizTest
