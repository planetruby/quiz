require 'minitest/autorun'


#
# An entry by  Frank J. Cameron
#    see https://rubytalk.org/t/re-ruby-quiz-challenge-4-turn-humanitarian-exchange-language-hxl-tabular-records-into-named-tuples/74829


module Frank
def parse(recs)
    header_index = recs.find.with_index do |rec, i|
      break i if rec.any?{|r| r[0] == ?# }
    end
    header_rec = recs[header_index].map do |r|
      r.delete!(?#)
    end
    recs[header_index+1..-1].map do |rec|
      {}.tap do |rec_hash|
        header_rec.zip(rec) do |(h,r)|
          next unless h
          if rec_hash.has_key?(h)
            if rec_hash[h].instance_of?(Array)
              rec_hash[h] << r
            else
              rec_hash[h] = [rec_hash[h]] << r
            end
          else
            rec_hash[h] = r
          end
        end
      end
    end
  end
end # module Frank


class RubyQuizTest < MiniTest::Test

  def recs1
       [["Organisation", "Cluster", "Province" ],
        [ "#org", "#sector", "#adm1" ],
        [ "Org A", "WASH", "Coastal Province" ],
        [ "Org B", "Health", "Mountain Province" ],
        [ "Org C", "Education", "Coastal Province" ],
        [ "Org A", "WASH", "Plains Province" ]]
  end

  def recs1_expected
         [{"org" => "Org A", "sector" => "WASH",      "adm1" => "Coastal Province"},
          {"org" => "Org B", "sector" => "Health",    "adm1" => "Mountain Province"},
          {"org" => "Org C", "sector" => "Education", "adm1" => "Coastal Province"},
          {"org" => "Org A", "sector" => "WASH",      "adm1" => "Plains Province"}]
  end

  def recs2
       [["What","","","Who","Where","For whom",""],
        ["Record","Sector/Cluster","Subsector","Organisation","Country","Males","Females","Subregion"],
        ["","#sector+en","#subsector","#org","#country","#sex+#targeted","#sex+#targeted","#adm1"],
        ["001","WASH","Subsector 1","Org 1","Country 1","100","100","Region 1"],
        ["002","Health","Subsector 2","Org 2","Country 2","","","Region 2"],
        ["003","Education","Subsector 3","Org 3","Country 2","250","300","Region 3"],
        ["004","WASH","Subsector 4","Org 1","Country 3","80","95","Region 4"]]
  end

  def recs2_expected
[{"sector+en"    => "WASH",
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
end
end # class RubyQuizTest



class FrankTest < RubyQuizTest
  include Frank

  def test_level1()   assert_equal recs1_expected, parse( recs1 ); end
  def test_level2()   assert_equal recs2_expected, parse( recs2 ); end
end
