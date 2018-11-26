###
## note: use ruby ./test.rb to run test


require 'minitest/autorun'
require 'date'



def convert( values )
  ## ...
end



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
