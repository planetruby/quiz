###
## note: use ruby ./test.rb to run test



require 'minitest/autorun'


def parse( txt )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_parse    # level 1

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

  def test_parse_level2
    records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

    assert_equal records, parse( <<TXT )
1, "Hamlet says, ""Seems,"" madam! Nay it is; I know not ""seems."""
TXT
  end

  def test_parse_level3
    records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

    assert_equal records, parse( <<TXT )
1, "Hamlet says, \\"Seems,\\" madam! Nay it is; I know not \\"seems.\\""
TXT
  end


  def test_parse_level4
    records = [["1", "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"],
               ["2", 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."']]

    assert_equal records, parse( <<TXT )
1, "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"
2, 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."'
TXT
end

end # class RubyQuizTest
