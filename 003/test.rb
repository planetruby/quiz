###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'
require 'pp'



def parse( html )
  ## ...
end




class RubyQuizTest < MiniTest::Test

  def test_parse

    #######
    # Pos Team P W D L F A GD Pts

    lines =<<TXT
    1  Man City 10 8 2 0 27 3 24 26
    2  Liverpool 10 8 2 0 20 4 16 26
    3  Chelsea 10 7 3 0 24 7 17 24
    4  Arsenal 10 7 1 2 24 13 11 22
    5  Tottenham 10 7 0 3 16 8 8 21
    6  Bournemouth 10 6 2 2 19 12 7 20
    7  Watford 10 6 1 3 16 12 4 19
    8  Man Utd 10 5 2 3 17 17 0 17
    9  Everton 10 4 3 3 16 14 2 15
    10  Wolves 10 4 3 3 9 9 0 15
    11  Brighton 10 4 2 4 11 13 -2 14
    12  Leicester 10 4 1 5 16 16 0 13
    13  West Ham 10 2 2 6 9 15 -6 8
    14  Crystal Palace 10 2 2 6 7 13 -6 8
    15  Burnley 10 2 2 6 10 21 -11 8
    16  Southampton 10 1 4 5 6 14 -8 7
    17  Cardiff 10 1 2 7 9 23 -14 5
    18  Fulham 10 1 2 7 11 28 -17 5
    19  Newcastle 10 0 3 7 6 14 -8 3
    20  Huddersfield 10 0 3 7 4 21 -17 3
TXT

    table = []
    lines.each_line {|line| table << line.split }
    pp table

    assert_equal table, parse( File.read( "./pages/bbc.html" ))

  end # method test_parse
end # class RubyQuizTest
