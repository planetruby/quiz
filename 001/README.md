# Ruby Quiz - Challenge #1 - Read Comma-Separated Values (CSV) from the "Real World"


Let's use the [`test.csv`](https://github.com/apache/commons-csv/blob/master/src/test/resources/CSVFileParser/test.csv) file from Apache Commons CSV Reader.
The challenge: Code a parse method that passes the RubyQuizTest :-).
Start from scratch or, yes, use any library / gem you can find.

``` ruby
def parse( txt )
  # ...
end
```

To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'


class RubyQuizTest < MiniTest::Test

  def test_parse   # level 1

    records = [["A", "B", "C", "D"],
              ["a", "b", "c", "d"],
              ["e", "f", "g", "h"],
              [" i ", " j ", " k ", " l "],
              ["", "", "", ""],
              ["", "", "", ""]]


    assert_equal records, parse( <<TXT )
A,B,C,"D"
# plain values
a,b,c,d
# spaces before and after
 e ,f , g,h
# quoted: with spaces before and after
" i ", " j " , " k "," l "
# empty values
,,,
# empty quoted values
"","","",""
# 3 empty lines



# EOF on next line
TXT

  end # method test_parse
end # class RubyQuizTest
```

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).



## Bonus:  Let's Add Three More Difficulty Levels

### Level 2 - Commas Inside Quotes and Double Up Quotes in Quotes

Let's turn Shakespeare's "literal" Hamlet quote:

```
Hamlet says, "Seems," madam! Nay it is; I know not "seems."
```

into

```
1, "Hamlet says, ""Seems,"" madam! Nay it is; I know not ""seems."""
```

And the test reads:

``` ruby
def test_parse_level2
  records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

  assert_equal records, parse( <<TXT )
1, "Hamlet says, ""Seems,"" madam! Nay it is; I know not ""seems."""
TXT
end
```




### Level 3 - Unix/Ruby-Style Backslash Escapes

Lets add the "unix-style" escaping with backslashes (e.g. `\"` for `""`)
used by Ruby :-), PostgreSQL, MySQL and others
(when exporting database tables in CSV, for example):

```
1, "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""
```

And the test reads:

``` ruby
def test_parse_level3
  records = [["1", "Hamlet says, \"Seems,\" madam! Nay it is; I know not \"seems.\""]]

  assert_equal records, parse( <<TXT )
1, "Hamlet says, \\"Seems,\\" madam! Nay it is; I know not \\"seems.\\""
TXT
end
```



### Level 4 - Single or Double? Mixed Quotes

Let's again get inspired by Ruby :-) -
see [210 Ways to Rome](https://idiosyncratic-ruby.com/15-207-ways-to-rome.html)
and lets add single or double quotes.

```
1, "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"
2, 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."'
```

And the test reads:

``` ruby
def test_parse_level4
  records = [["1", "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"],
             ["2", 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."']]

  assert_equal records, parse( <<TXT )
1, "Hamlet says, 'Seems,' madam! Nay it is; I know not 'seems.'"
2, 'Hamlet says, "Seems," madam! Nay it is; I know not "seems."'
TXT
end
```


Happy hacking and data wrangling with Ruby.
