require 'minitest/autorun'


#
# Two entries
#  by  Frank J. Cameron
#    see https://rubytalk.org/t/re-ruby-quiz-challenge-6-build-the-table-of-contents-toc-for-documents-in-markdown/74852

module Frank
  module V1

  def toc(txt)
    txt
    .lines
    .lazy
    .select{|l| l.match(/^(#+)\s+(.*)\s*$/)}
    .map{|l| [$~[1].length, $~[2]]}
    .slice_when{|a, b| a[0] != b[0]}
    .to_a
    .yield_self do |z|
      # https://en.wikipedia.org/wiki/Overfitting 1 :wink:
      [
        z[0].flatten << [
          z[1].flatten << z[2]
        ] + [
          z[3].flatten << z[4]
        ] + [
          z[5].flatten << z[6]
        ] + [
          z[7].flatten << z[8]
        ] + [
          z[9].flatten << z[10]
        ]
      ]
    end
  end

end # module V1

module V2
##
## gem 'rubytree', '~> 1.0'
require 'tree'

  def toc(txt)
    _d(_f(_h(txt)))
  end

 ## private

  def _d(r)
    r.children.map do |c|
      (g = _d(c)).size > 0 ? c.name + [g] : c.name
    end
  end

  def _f(h, n = Tree::TreeNode.new([0, nil]))
    return n.root unless h[0]

    c = Tree::TreeNode.new(h[0])

    case h[0][0] <=> n.name[0]
    when 1
      n << c
    when 0
      n.parent << c
    else
      n.parent.parent << c
    end

    _f(h[1..-1], c)
  end

  def _h(txt)
    txt
    .scan(/^(#+)\s+(.*)\s*$/)
    .map{|(a,b)| [a.length, b]}
  end

end # module V2
end # module Frank



#
# Test entry
#   by Gerald Bauer

module Test
##
HEADING_RX = /^
              \s*
              (?<level>\#+)
              \s*
              (?<title>.*?)
              \s*
              $/x

def toc( txt )
  headings = []

  stack = []
  parent = nil

  txt.each_line do |line|
    line = line.chomp( '' )

    pp line
    if (m=HEADING_RX.match(line))

      level = m[:level].size
      level_str = m[:level]
      title = m[:title]

      puts " level: (#{level}) >#{level_str}<"
      puts " title: >#{title}<"

      item = [level,title]

      if stack.empty? # root - let's start
         headings << item
         stack.push( headings )
         parent = item
      else
        parent_level = parent[0]
        level_diff = level - parent_level
        if level_diff > 0
          ## up
          puts " up +#{level_diff}"
        elsif level_diff < 0
          ## down
          puts " down #{level_diff}"
          level_diff.abs.times { stack.pop }
          parent = stack.pop
        else
          ## same level
          parent = stack.pop
        end
        parent[2] ||= []
        parent[2] << item
        stack.push( parent )
        parent = item
      end
    end
  end

  headings
end
end # module Test



class RubyQuizTest < MiniTest::Test

  def txt
    File.open( "./pages/meetups.md", "r:utf-8" ).read
  end

  def headings
     [[2, "Europe",
  [[3, "Central Europe",
    [[4, "Austria / \xC3\x96sterreich (at)"],
     [4, "Switzerland / Schweiz / Suisse / Confoederatio Helvetica (ch)"],
     [4, "Germany / Deutschland (de)"],
     [4, "Slovakia (sk)"],
     [4, "Slovenia (si)"],
     [4, "Czech Republic (cz)"],
     [4, "Poland (pl)"],
     [4, "Hungary (hu)"]]],
   [3, "Western Europe",
    [[4, "England (en)"],
     [4, "Scotland"],
     [4, "Northern Ireland"],
     [4, "Ireland / \xC3\x89ire (ie)"],
     [4, "France (fr)"],
     [4, "Belgium / Belgi\xC3\xAB / Belgique (be)"],
     [4, "Netherlands (nl)"]]],
   [3, "Southern Europe",
    [[4, "Spain / Espa\xC3\xB1a (es)"],
     [4, "Portugal (pt)"],
     [4, "Italy (it)"],
     [4, "Croatia / Hrvatska (hr)"]]],
   [3, "Northern Europe",
    [[4, "Denmark / Danmark (dk)"],
     [4, "Sweden / Sverige (se)"],
     [4, "Finland / Suomi (fi)"],
     [4, "Norway / Norge (no)"],
     [4, "Lithuania / Lietuva (lt)"]]],
   [3, "Eastern Europe",
    [[4, "Belarus / \xD0\x91\xD0\xB5\xD0\xBB\xD0\xB0\xD1\x80\xD1\x83\xD1\x81\xD1\x8C (by)"],
     [4, "Bulgaria (bg)"],
     [4, "Romania / Rom\xC3\xA2nia (ro)"],
     [4, "Russia / \xD0\xA0\xD0\xBE\xD1\x81\xD1\x81\xD0\xB8\xD1\x8F (ru)"],
     [4, "Ukraine / \xD0\xA3\xD0\xBA\xD1\x80\xD0\xB0\xD1\x97\xD0\xBD\xD0\xB0 (ua)"]]]]]]
  end # method headings
end # class RubyQuizTest



class FrankV1Test < RubyQuizTest
  include Frank::V1

  def test_toc
    assert_equal headings, toc( txt )
  end
end

class FrankV2Test < RubyQuizTest
  include Frank::V2

  def test_toc
    assert_equal headings, toc( txt )
  end
end

class TestTest < RubyQuizTest
  include Test

  def test_toc
    assert_equal headings, toc( txt )
  end
end
