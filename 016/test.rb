###
## note: use ruby ./test.rb to run test


require 'yaml'
require 'minitest/autorun'


def build( txt )
  # ...
end


class RubyQuizTest < MiniTest::Test

  def test_build
    txt      = File.open( "./manuscript/index.md",          "r:utf-8" ).read
    headings = File.open( "./manuscript/META/contents.yml", "r:utf-8" ).read

    assert_equal YAML.load( headings ),
                 YAML.load( build( txt ))
  end # method test_build
end # class RubyQuizTest
