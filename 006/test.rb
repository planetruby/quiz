###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'


def toc( txt )
  ## ...
end


class RubyQuizTest < MiniTest::Test

  def test_toc

    headings = [[2, "Europe",
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

    assert_equal headings, toc( File.open( "./pages/meetups.md", "r:utf-8" ).read )

  end # method test_toc
end # class RubyQuizTest
