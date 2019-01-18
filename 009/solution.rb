####
# Entry by Frank J. Cameron
#   see https://rubytalk.org/t/re-ruby-quiz-challenge-9-tally-up-calculate-the-standings-table-for-the-english-premier-league-2018-19-season-and-the-winner-is-liverpool-manchester-city/74884

module Frank
  # [ Team 1, Raw Score (Score 1 - Score 2), Team 2 ]
  #
  # Team Name:
  # [ 0: Played | 1: Won | 2: Drawn | 3: Lost |
  # | 4: Goals for | 5: Goals against |
  # | 6: Points (+3/+1 for win/tie) ]
  #
  def tallyup(matches)
    Hash.new{|h,k| h[k] = Array.new(7){0}}.tap{|h|
      matches.drop(1).each do |t1, rs, t2|
        s1, s2 = rs.split('-').map(&:to_i)
        h[t1][0] += 1; h[t2][0] += 1
        h[t1][4] += s1; h[t2][4] += s2
        h[t1][5] += s2; h[t2][5] += s1
        case s1 <=> s2
        when 1
          h[t1][1] += 1; h[t2][3] += 1; h[t1][6] += 3
        when 0
          h[t1][2] += 1; h[t1][6] += 1
                         h[t2][2] += 1; h[t2][6] += 1
        else
          h[t1][3] += 1; h[t2][1] += 1; h[t2][6] += 3
        end
      end
    }
    .sort_by{|_,v| [-v[6], v[5]-v[4], -v[4]]}
    .map {|k,v| [k]+v}
  end
end # module Frank


#############
# Test entry
#   by Gerald Bauer

module TestAnswer
def tallyup( matches )
  require 'sportdb/text'

  # step 1: convert match array to match "struct / named tuple"
  matches = matches.map do |match|
    team1 = match[0]
    score1, score2 = match[1].split('-')
    team2 = match[2]

    SportDb::Struct::Match.create(
      team1: team1,
      score1: score1,
      score2: score2,
      team2: team2
   )
  end

  # step 2: tally up standings
  standings = SportDb::Struct::Standings.new
  standings.update( matches )
  ## note: for the black box "magic" see http://github.com/yorobot/football.csv/blob/master/sportdb-text/lib/sportdb/text/structs/standings.rb#L175

  # step 3: convert to array of arrays
  recs = []
  standings.to_a.each do |l|
    recs << [
       l.team,
       l.played,
       l.won,
       l.drawn,
       l.lost,
       l.goals_for,
       l.goals_against,
       l.pts
    ]
  end
  recs
end
end
