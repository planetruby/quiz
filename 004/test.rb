###
## note: use ruby ./test.rb to run test



require 'minitest/autorun'



def parse( recs )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_level1
    recs = [
        ["Organisation", "Cluster", "Province" ],
        [ "#org", "#sector", "#adm1" ],
        [ "Org A", "WASH", "Coastal Province" ],
        [ "Org B", "Health", "Mountain Province" ],
        [ "Org C", "Education", "Coastal Province" ],
        [ "Org A", "WASH", "Plains Province" ]]

    recs_expected = [
          {"org" => "Org A", "sector" => "WASH",      "adm1" => "Coastal Province"},
          {"org" => "Org B", "sector" => "Health",    "adm1" => "Mountain Province"},
          {"org" => "Org C", "sector" => "Education", "adm1" => "Coastal Province"},
          {"org" => "Org A", "sector" => "WASH",      "adm1" => "Plains Province"}]

    assert_equal recs_expected, parse( recs )
  end # method test_level1

  def test_level2
    recs = [
        ["What","","","Who","Where","For whom",""],
        ["Record","Sector/Cluster","Subsector","Organisation","Country","Males","Females","Subregion"],
        ["","#sector+en","#subsector","#org","#country","#sex+#targeted","#sex+#targeted","#adm1"],
        ["001","WASH","Subsector 1","Org 1","Country 1","100","100","Region 1"],
        ["002","Health","Subsector 2","Org 2","Country 2","","","Region 2"],
        ["003","Education","Subsector 3","Org 3","Country 2","250,300","Region 3"],
        ["004","WASH","Subsector 4","Org 1","Country 3","80","95","Region 4"]]

    recs_expected = [
 {"sector+en"    => "WASH",
  "subsector"    => "Subsector 1",
  "org"          => "Org 1",
  "country"      => "Country 1",
  "sex+targeted" => ["100", "100"],
  "adm1"         => "Region 1"},
 {"sector+en"    => "Health",
  "subsector"    => "Subsector 2",
  "org"          => "Org 2",
  "country"      => "Country 2",
  "sex+targeted" => ["", ""],
  "adm1"         => "Region 2"},
 {"sector+en"    => "Education",
  "subsector"    => "Subsector 3",
  "org"          => "Org 3",
  "country"      => "Country 2",
  "sex+targeted" => ["250", "300"],
  "adm1"         => "Region 3"},
 {"sector+en"    => "WASH",
  "subsector"    => "Subsector 4",
  "org"          => "Org 1",
  "country"      => "Country 3",
  "sex+targeted" => ["80", "95"],
  "adm1"         => "Region 4"}]

    assert_equal recs_expected, parse( recs )
  end # method test_level2
end # class RubyQuizTest
