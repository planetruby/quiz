require 'minitest/autorun'



#
# A simple solution using core String and Regexp features.
#   by Dave Burt
#    see https://rubytalk.org/t/ruby-quiz-is-back-challenge-1-read-comma-separated-values-csv-from-the-real-world/74802/2

module Dave
def parse( text )
  text.each_line.map do |line|
    next if line =~ /^#/ || line =~ /^\s+$/
    line.strip.split(/\s*,\s*/, -1).map do |field|
      field.sub(/^(['"])(.*)\1$/, '\\2')
    end
  end.compact
end
end

#
# A entry using String and Regex
#  by  Frank J. Cameron
#    see https://rubytalk.org/t/re-ruby-quiz-is-back-challenge-1-read-comma-separated-values-csv-from-the-real-world/74809

module Frank
module V1
def parse( text )
  text.lines.map do |line|
    next if line.match(/^\s*$|#/)
    line.strip.split(/\s*,\s*/, -1)
  end.compact.map do |cells|
    cells.map do |cell|
      cell.match(/"(.*)"/) ? $1 : cell
    end
  end
end
end  # module V1

module V2
##
## see https://rubytalk.org/t/ruby-quiz-1-bonus-three-more-difficulty-levels-2-3-4-commas-inside-quotes-and-double-up-quotes-in-quotes/74816/2

def parse( text )
      text.lines.map do |line|
        next if line.match(/^\s*$|#/)
        line
        .strip
        .gsub(/"(([^"\\]|"")*(\\.([^"\\]|"")*)*)"|\'([^\'\\]*(\\.[^\'\\]*)*)\'/){
          "\000#{
            Regexp.last_match
            .to_a[1..-1]
            .compact[0]
            .gsub(/,/, "\001")
            .gsub(/\\"|""/, '"')
          }\000"
        }
        .split(/\s*,\s*/, -1)
      end.compact.map do |cells|
        cells.map do |cell|
          cell
          .gsub(/\001/, ',')
          .gsub(/\000/, '')
        end
      end
end
end  # module V2
end  # module Frank



#
# A solution using FSM (Finite State Machine)
#  by Paul Sonkoly
#
#  source @ https://github.com/phaul/mealy

module Paul

require 'mealy'

class CSV
  include Mealy

  initial_state(:start) { @line = []; @text = '' }

  read(state: :start, on: "\n")

  transition(from: :start, to: :comment, on: '#')
  transition(from: :comment, to: :start, on: "\n")
  read(state: :comment)


  transition from: [:normal, :start], to: :quote, on: '"'
  transition from: :quote, to: :normal, on: '"'

  transition(from: :start, to: :normal, on: ',') { @line << '' }
  transition(from: :start, to: :normal, on: ' ')
  transition(from: :start, to: :normal) { |c| @text << c }
  transition(from: :normal, to: :start, on: "\n") do
    emit @line << @text; @line = []; @text = ''
  end

  read state: :normal, on: ' '
  read(state: :normal, on: ',') {  @line << @text; @text = '' }

  read(state: [ :normal, :quote ]) { |c| @text << c }

  finish { emit @line unless @line.empty? }
end

def parse( txt )
  CSV.new.run( txt.chars ).entries
end
end




class RubyQuizTest < MiniTest::Test

  RECORDS = {}
  TXT =     {}

  RECORDS[:level1]=
[["A", "B", "C", "D"],
              ["a", "b", "c", "d"],
              ["e", "f", "g", "h"],
              [" i ", " j ", " k ", " l "],
              ["", "", "", ""],
              ["", "", "", ""]]

  TXT[:level1]=<<TXT
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


  RECORDS[:level2]=
     [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

  TXT[:level2]=<<TXT
1, "Hamlet says, ""Seems,"" madam! Nay it is; I know not ""seems."""
TXT

  RECORDS[:level3]=
     [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

  TXT[:level3]=<<TXT
1, "Hamlet says, \\"Seems,\\" madam! Nay it is; I know not \\"seems.\\""
TXT

  RECORDS[:level4]=
     [["1", "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"],
      ["2", 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."']]

  TXT[:level4]=<<TXT
1, "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"
2, 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."'
TXT


  def records() RECORDS[:level1]; end
  def txt()     TXT[:level1]; end

end # class RubyQuizTest


class DaveTest < RubyQuizTest
  include Dave

  def test_parse()   assert_equal records, parse( txt ); end
end


class FrankTestV1 < RubyQuizTest
  include Frank::V1

  def test_parse()   assert_equal records, parse( txt ); end
end

class FrankTestV2 < RubyQuizTest
  include Frank::V2

  def test_parse()         assert_equal records, parse( txt ); end
  def test_parse_level2()  assert_equal RECORDS[:level2], parse( TXT[:level2] ); end
  def test_parse_level3()  assert_equal RECORDS[:level3], parse( TXT[:level3] ); end
  def test_parse_level4()  assert_equal RECORDS[:level4], parse( TXT[:level4] ); end
end



class PaulTest < RubyQuizTest
  include Paul

  def test_parse()   assert_equal records, parse( txt ); end
end
