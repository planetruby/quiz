# Ruby Quiz - Challenge #4 - Turn Humanitarian eXchange Language (HXL) Tabular Records into Named Tuples

Let's turn tabular data using the Humanitarian eXchange Language (HXL) 
hashtag convention from array of array of strings 
to array of named tuples (also known as hash dictionaries).


Aside: What's Humanitarian eXchange Language (HXL)?

[Humanitarian eXchange Language (HXL)](https://github.com/csvspecs/csv-hxl)
is a (meta data) convention for
adding agreed on hashtags e.g. `#org,#country,#sex+#targeted,#adm1`
inline in a (single new line)
between the last header row and the first data row
for sharing tabular data across organisations
(during a humanitarian crisis).
Example:

```
What,,,Who,Where,For whom,
Record,Sector/Cluster,Subsector,Organisation,Country,Males,Females,Subregion
,#sector+en,#subsector,#org,#country,#sex+#targeted,#sex+#targeted,#adm1
001,WASH,Subsector 1,Org 1,Country 1,100,100,Region 1
002,Health,Subsector 2,Org 2,Country 2,,,Region 2
003,Education,Subsector 3,Org 3,Country 2,250,300,Region 3
004,WASH,Subsector 4,Org 1,Country 3,80,95,Region 4
```


The challenge: Code a parse method that passes the RubyQuizTest :-).

``` ruby
def parse( recs )
  # ...
end
```

For the starter level 1 turn:

``` ruby
parse( [["Organisation", "Cluster", "Province" ],
        [ "#org", "#sector", "#adm1" ],
        [ "Org A", "WASH", "Coastal Province" ],
        [ "Org B", "Health", "Mountain Province" ],
        [ "Org C", "Education", "Coastal Province" ],
        [ "Org A", "WASH", "Plains Province" ]] )
```

into

``` ruby
[{"org" => "Org A", "sector" => "WASH",      "adm1" => "Coastal Province"},
 {"org" => "Org B", "sector" => "Health",    "adm1" => "Mountain Province"},
 {"org" => "Org C", "sector" => "Education", "adm1" => "Coastal Province"},
 {"org" => "Org A", "sector" => "WASH",      "adm1" => "Plains Province"}]
```


Bonus: For a greater level 2 challenge with three extra rules:

- Skip / ignore extra header rows (e.g. one or more rows before hashtag line / row)
- Skip / ignore "untagged" fields / columns (e.g. `""`) in the hashtag line / row in the named tuple hash dictionary
- Fold repeat (duplicate) fields / columns (e.g. `#sex+#targeted`) into a list / array


Turn:

``` ruby
parse( [["What","","","Who","Where","For whom",""],
        ["Record","Sector/Cluster","Subsector","Organisation","Country","Males","Females","Subregion"],
        ["","#sector+en","#subsector","#org","#country","#sex+#targeted","#sex+#targeted","#adm1"],
        ["001","WASH","Subsector 1","Org 1","Country 1","100","100","Region 1"],
        ["002","Health","Subsector 2","Org 2","Country 2","","","Region 2"],
        ["003","Education","Subsector 3","Org 3","Country 2","250,300","Region 3"],
        ["004","WASH","Subsector 4","Org 1","Country 3","80","95","Region 4"]] )
```

into

``` ruby
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
```


Start from scratch or, yes, use any library / gem you can find.


To qualify for solving the code challenge / puzzle you must pass the test:

```ruby
require 'minitest/autorun'

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
```

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).


Happy hacking and data wrangling with Ruby.

