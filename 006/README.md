# Ruby Quiz - Challenge #6 - Build the Table of Contents (ToC) for Documents in Markdown


Let's read text documents and build up the table of contents from the headings hierarchy / tree.

---
Aside: What's text with markdown formatting conventions?

Markdown uses hashtags (`#`) for marking up headings. Example:

``` md
# Heading Level 1
## Heading Level 2
### Heading Level 3
#### Heading Level 4
...
```

---



The challenge: Code a `toc` (table of contents) method that passes the RubyQuizTest :-).

``` ruby
def toc( txt )
  # ...
end
```

For the starter level 1 build the table of contents (toc)
for the [ruby meetups in europe document / page](https://github.com/planetruby/calendar/blob/master/meetups/EUROPE.md) in text with markdown formatting conventions.
Example (Note: All text stripped for clarity, that is,
making it clear to see the heading hierarchy / tree structure):


``` md
## Europe
### Central Europe
#### Austria / Österreich (at)
#### Switzerland / Schweiz / Suisse / Confoederatio Helvetica (ch)
#### Germany / Deutschland (de)
#### Slovakia (sk)
#### Slovenia (si)
#### Czech Republic (cz)
#### Poland (pl)
#### Hungary (hu)
### Western Europe
#### England (en)
#### Scotland
#### Northern Ireland
#### Ireland / Éire (ie)
#### France (fr)
#### Belgium / België / Belgique (be)
#### Netherlands (nl)
### Southern Europe
#### Spain / España (es)
#### Portugal (pt)
#### Italy (it)
#### Croatia / Hrvatska (hr)
### Northern Europe
#### Denmark / Danmark (dk)
#### Sweden / Sverige (se)
#### Finland / Suomi (fi)
#### Norway / Norge (no)
#### Lithuania / Lietuva (lt)
### Eastern Europe
#### Belarus / Беларусь (by)
#### Bulgaria (bg)
#### Romania / România (ro)
#### Russia / Россия (ru)
#### Ukraine / Україна / Украина (ua)
```

into

``` ruby
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
```


Note: For easy reference and testing you can use the "local" page, see [`pages/meetups.md`](pages/meetups.md).


To qualify for solving the code challenge / puzzle you must pass the test:


```ruby
require 'minitest/autorun'

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
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy text processing with Ruby.
