# Ruby Quiz - Challenge #3 - Read the English Premier League (EPL) Standings Table from a Web Page


Let's read the English Premier League (EPL) Standings Table
from a web page. Let's use the British Broadcasting Corp (BBC) page @ [`bbc.com/sport/football/premier-league/table`](https://www.bbc.com/sport/football/premier-league/table) as a start.


The challenge: Code a parse method that passes the RubyQuizTest :-).

``` ruby
def parse( html )
  # ...
end
```

Start from scratch or, yes, use any library / gem you can find.
Scrap the standings table (as an array of array of string values) e.g.:

``` ruby
[["1", "Man City", "10", "8", "2", "0", "27", "3", "24", "26"],
 ["2", "Liverpool", "10", "8", "2", "0", "20", "4", "16", "26"],
 ["3", "Chelsea", "10", "7", "3", "0", "24", "7", "17", "24"],
 ["4", "Arsenal", "10", "7", "1", "2", "24", "13", "11", "22"],
 ["5", "Tottenham", "10", "7", "0", "3", "16", "8", "8", "21"],
 ["6", "Bournemouth", "10", "6", "2", "2", "19", "12", "7", "20"],
 ["7", "Watford", "10", "6", "1", "3", "16", "12", "4", "19"],
 ["8", "Man Utd", "10", "5", "2", "3", "17", "17", "0", "17"],
 ["9", "Everton", "10", "4", "3", "3", "16", "14", "2", "15"],
 ["10", "Wolves", "10", "4", "3", "3", "9", "9", "0", "15"],
 ["11", "Brighton", "10", "4", "2", "4", "11", "13", "-2", "14"],
 ["12", "Leicester", "10", "4", "1", "5", "16", "16", "0", "13"],
 ["13", "West Ham", "10", "2", "2", "6", "9", "15", "-6", "8"],
 ["14", "Crystal Palace", "10", "2", "2", "6", "7", "13", "-6", "8"],
 ["15", "Burnley", "10", "2", "2", "6", "10", "21", "-11", "8"],
 ["16", "Southampton", "10", "1", "4", "5", "6", "14", "-8", "7"],
 ["17", "Cardiff", "10", "1", "2", "7", "9", "23", "-14", "5"],
 ["18", "Fulham", "10", "1", "2", "7", "11", "28", "-17", "5"],
 ["19", "Newcastle", "10", "0", "3", "7", "6", "14", "-8", "3"],
 ["20", "Huddersfield", "10", "0", "3", "7", "4", "21", "-17", "3"]]
```

from the html table that you can find inside the web page's source.


To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'


class RubyQuizTest < MiniTest::Test

  def test_parse

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

    assert_equal table, parse( File.read( "./pages/bbc.html" ))

  end # method test_parse
end # class RubyQuizTest
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Note: For easy reference and testing you can use the "local"
page, see [`pages/bbc.html`](pages/bbc.html).


Bonus: You're welcome to use a different web page
or a different football league.
