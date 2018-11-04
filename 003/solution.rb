require 'minitest/autorun'


#
# An entry using Hpricot
#  and another entry using Oga
#
#  by  Frank J. Cameron
#    see https://rubytalk.org/t/re-ruby-quiz-challenge-3-read-the-english-premier-league-epl-standings-table-from-a-web-page/74820

module Frank
module V1
require 'hpricot'

def parse( html )
  Hpricot(html).search('table/tbody/tr').map do |tr|
      tr.search('td').map.each_with_index do |td, i|
        case i
        when 0, 2
          td.inner_text
        when 1
        else
          Integer(td.inner_text).to_s rescue nil
        end
      end.compact
  end
end
end # module V1


module V2
require 'oga'

def parse( html )
  Oga.parse_html(html).xpath('table/tbody/tr').map do |tr|
        tr.xpath('td').map.each_with_index do |td, i|
          case i
          when 0, 2
            td.text
          when 1
          else
            Integer(td.text).to_s rescue nil
          end
        end.compact
  end
end
end # module V2
end # module Frank





class RubyQuizTest < MiniTest::Test

  def table

    #######
    # Pos Team P W D L F A GD Pts

    lines =<<TXT
    1  Man_City 10 8 2 0 27 3 24 26
    2  Liverpool 10 8 2 0 20 4 16 26
    3  Chelsea 10 7 3 0 24 7 17 24
    4  Arsenal 10 7 1 2 24 13 11 22
    5  Tottenham 10 7 0 3 16 8 8 21
    6  Bournemouth 10 6 2 2 19 12 7 20
    7  Watford 10 6 1 3 16 12 4 19
    8  Man_Utd 10 5 2 3 17 17 0 17
    9  Everton 10 4 3 3 16 14 2 15
    10  Wolves 10 4 3 3 9 9 0 15
    11  Brighton 10 4 2 4 11 13 -2 14
    12  Leicester 10 4 1 5 16 16 0 13
    13  West_Ham 10 2 2 6 9 15 -6 8
    14  Crystal_Palace 10 2 2 6 7 13 -6 8
    15  Burnley 10 2 2 6 10 21 -11 8
    16  Southampton 10 1 4 5 6 14 -8 7
    17  Cardiff 10 1 2 7 9 23 -14 5
    18  Fulham 10 1 2 7 11 28 -17 5
    19  Newcastle 10 0 3 7 6 14 -8 3
    20  Huddersfield 10 0 3 7 4 21 -17 3
TXT

    table = []
    lines.each_line { |line| table << line.split.map {|cell| cell.tr('_',' ') } }
    table
  end

  def html
    File.read( "./pages/bbc.html" )
  end
end # class RubyQuizTest





class FrankTestV1 < RubyQuizTest
  include Frank::V1

  def test_parse
    assert_equal table, parse( html )
  end
end

class FrankTestV2 < RubyQuizTest
  include Frank::V2

  def test_parse
    assert_equal table, parse( html )
  end
end
