# Ruby Quiz - Challenge #7 - Type Inference - Convert Strings to Null, Number, Not a Number (NaN), Date & More

Type inference is the new hotness.
Let's (auto)-convert a list of strings into properly typed values.


The challenge: Code a `convert` method that passes the RubyQuizTest :-).

``` ruby
def convert( values )
  # ...
end
```

For the starter level 1 turn a random list of strings:

``` ruby
["2018", "2018.12", "2018.12.25", "25 Gems", "NaN", "1820", "18.20", "Nil", "Null"]
```

into a properly typed list of values:

```
[2018, 2018.12, #<Date: 2018-12-25>, "25 Gems", NaN, 1820, 18.2, nil, nil]
```

Note: `NaN` is short for Not a Number (that is, `Float::NAN`).
To pass the RubyQuizTest all type classes must match too, that is:

```
[Integer, Float, Date, String, Float, Integer, Float, NilClass, NilClass]
```

To make sure the order in the list doesn't matter, that is, integer before float numbers
or float before integer numbers or date before integer numbers
and so on -
convert gets called five times
with a shuffled sample with a different "randomized" order every time.


Start from scratch or, yes, use any library / gem you can find.

To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'
require 'date'

class RubyQuizTest < MiniTest::Test

  def test_convert

    pairs = [
      ["2018",       2018],
      ["2018.12",    2018.12],
      ["2018.12.25", Date.new(2018,12,25)],
      ["25 Gems",    "25 Gems"],
      ["NaN",        Float::NAN],
      ["1820",       1820],
      ["18.20",      18.2],
      ["Nil",        nil],
      ["Null",       nil]]

    5.times do
      values, exp_values = pairs.shuffle.reduce( [[],[]]) { |acc,pair| acc[0] << pair[0]; acc[1] << pair[1]; acc }

      assert_equal exp_values, convert( values )
      assert_equal exp_values.map { |v| v.class }, convert( values ).map { |v| v.class }
    end


  end # method test_convert
end # class RubyQuizTest
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy data wrangling and type inferencing with Ruby.
