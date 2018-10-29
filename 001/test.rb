require 'minitest/autorun'



#
# A simple solution using core String and Regexp features.
#   by Dave Burt
#    see https://rubytalk.org/t/ruby-quiz-is-back-challenge-1-read-comma-separated-values-csv-from-the-real-world/74802/2

module Dave
def parse( txt )
  txt.each_line.map do |line|
    next if line =~ /^#/ || line =~ /^\s+$/
    line.strip.split(/\s*,\s*/, -1).map do |field|
      field.sub(/^(['"])(.*)\1$/, '\\2')
    end
  end.compact
end
end



class RubyQuizTest < MiniTest::Test

  def records
[["A", "B", "C", "D"],
              ["a", "b", "c", "d"],
              ["e", "f", "g", "h"],
              [" i ", " j ", " k ", " l "],
              ["", "", "", ""],
              ["", "", "", ""]]

  end

  def txt
<<TXT  
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
end
end # class RubyQuizTest


class DaveTest < RubyQuizTest
  include Dave

  def test_parse
    assert_equal records, parse( txt )
  end # method test_parse

end
