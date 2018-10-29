###
## note: use ruby ./test.rb to run test 



require 'minitest/autorun'


def parse( txt )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_parse

    records = [["A", "B", "C", "D"],
              ["a", "b", "c", "d"],
              ["e", "f", "g", "h"],
              [" i ", " j ", " k ", " l "],
              ["", "", "", ""],
              ["", "", "", ""]]


    assert_equal records, parse( <<TXT )
A,B,C,"D"
# plain values
a,b,c,d
# spaces before and after
 e ,f , g,h
# quoted: with spaces before and after
" i ", " j " , " k "," l "
# empty values
,,,
# empty quoted values
"","","",""
# 3 empty lines



# EOF on next line
TXT

  end # method test_parse
end # class RubyQuizTest
