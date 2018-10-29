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



#
# A solution using FSM (Finite State Machine)
#  by Paul Sonkoly
#    see https://www.reddit.com/r/ruby/comments/9sbbt3/ruby_quiz_is_back_a_fortnightly_programming/
#
# note: waiting for mealy gem to get published to rubygems
#  source @ https://github.com/phaul/mealy

module Paul
  
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

class PaulTest < RubyQuizTest
  include Paul

  def test_parse
    assert_equal records, parse( txt )
  end # method test_parse
end

