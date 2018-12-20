###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'


def tallyup( matches )
  ## ...
end


class RubyQuizTest < MiniTest::Test

  def test_tallyup_2018_19
    standings = [["Liverpool FC",               17, 14, 3,  0, 37,  7, 45],
                 ["Manchester City FC",         17, 14, 2,  1, 48, 10, 44],
                 ["Tottenham Hotspur FC",       17, 13, 0,  4, 31, 16, 39],
                 ["Chelsea FC",                 17, 11, 4,  2, 35, 14, 37],
                 ["Arsenal FC",                 17, 10, 4,  3, 37, 23, 34],
                 ["Manchester United FC",       17,  7, 5,  5, 29, 29, 26],
                 ["Wolverhampton Wanderers FC", 17,  7, 4,  6, 19, 19, 25],
                 ["Everton FC",                 17,  6, 6,  5, 24, 22, 24],
                 ["West Ham United FC",         17,  7, 3,  7, 25, 25, 24],
                 ["Watford FC",                 17,  7, 3,  7, 23, 25, 24],
                 ["AFC Bournemouth",            17,  7, 2,  8, 25, 28, 23],
                 ["Leicester City FC",          17,  6, 4,  7, 21, 21, 22],
                 ["Brighton & Hove Albion FC",  17,  6, 3,  8, 20, 24, 21],
                 ["Newcastle United FC",        17,  4, 4,  9, 14, 22, 16],
                 ["Crystal Palace FC",          17,  4, 3, 10, 14, 23, 15],
                 ["Cardiff City FC",            17,  4, 2, 11, 17, 33, 14],
                 ["Southampton FC",             17,  2, 6,  9, 16, 32, 12],
                 ["Burnley FC",                 17,  3, 3, 11, 15, 33, 12],
                 ["Huddersfield Town AFC",      17,  2, 4, 11, 10, 28, 10],
                 ["Fulham FC",                  17,  2, 3, 12, 16, 42,  9]]

     assert_equal standings, tallyup( read_matches("./datasets/2018-19.csv"))
  end # method test_tallyup_2018_19

  def test_tallyup_2017_18
    standings = [["Manchester City FC",        38, 32,  4,  2, 106, 27, 100],
                 ["Manchester United FC",      38, 25,  6,  7,  68, 28,  81],
                 ["Tottenham Hotspur FC",      38, 23,  8,  7,  74, 36,  77],
                 ["Liverpool FC",              38, 21, 12,  5,  84, 38,  75],
                 ["Chelsea FC",                38, 21,  7, 10,  62, 38,  70],
                 ["Arsenal FC",                38, 19,  6, 13,  74, 51,  63],
                 ["Burnley FC",                38, 14, 12, 12,  36, 39,  54],
                 ["Everton FC",                38, 13, 10, 15,  44, 58,  49],
                 ["Leicester City FC",         38, 12, 11, 15,  56, 60,  47],
                 ["Newcastle United FC",       38, 12,  8, 18,  39, 47,  44],
                 ["Crystal Palace FC",         38, 11, 11, 16,  45, 55,  44],
                 ["AFC Bournemouth",           38, 11, 11, 16,  45, 61,  44],
                 ["West Ham United FC",        38, 10, 12, 16,  48, 68,  42],
                 ["Watford FC",                38, 11,  8, 19,  44, 64,  41],
                 ["Brighton & Hove Albion FC", 38,  9, 13, 16,  34, 54,  40],
                 ["Huddersfield Town AFC",     38,  9, 10, 19,  28, 58,  37],
                 ["Southampton FC",            38,  7, 15, 16,  37, 56,  36],
                 ["Swansea City AFC",          38,  8,  9, 21,  28, 56,  33],
                 ["Stoke City FC",             38,  7, 12, 19,  35, 68,  33],
                 ["West Bromwich Albion FC",   38,  6, 13, 19,  31, 56,  31]]

    assert_equal standings, tallyup( read_matches("./datasets/2017-18.csv" ))
  end # method test_tallyup_2017_18



  ##################################################
  ## helper method

  MATCHNUM_RX = /\(\d{1,2}\)/   # e.g. (2) or (20)

  def read_matches( path )
    txt = File.read( path )
    matches = []
    txt.each_line do |line|
      values = line.split(',')

      next if values[2] == 'Team 1' && values[5] == 'Team 2'  ## skip header

      team1 = values[2].gsub( MATCHNUM_RX, '' ).strip  ## clean / remove (optional) match number
      team2 = values[5].gsub( MATCHNUM_RX, '' ).strip
      ft    = values[3]

      matches << [team1, ft, team2]
    end
    matches
  end
end # class RubyQuizTest
