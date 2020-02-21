# Ruby Quiz - Challenge #18 - Up-to-Date? Version Check All Your Libraries

Let's say you have a script
that depends on many libraries / gem.
How can you make sure the minimum version requirements
are fulfilled?

Let's look at a real-world example. If you run the pluto feed reader using the about option:

    $ pluto about

It will print:

```
Gems versions:
  - pakman 1.1.0
  - fetcher 0.4.5
  - feedparser 2.1.2
  - feedfilter 1.1.1
  - textutils 1.4.0
  - logutils 0.6.1
  - props 1.2.0

  - pluto 1.3.4
  - pluto-models 1.6.0
  - pluto-update 1.6.3
  - pluto-merge 1.1.0
  - pluto-tasks 1.5.3
```

Now the challenge: Code a `version_check( versions )`
method to version check the minimum requirements and return - if any - the outdated
libraries and versions AND that passes the RubyQuizTest :-).


``` ruby
def version_check( versions )
  # ...
end
```


Let's say you run:

``` ruby
outdated = version_check(
  ['pakman',            '1.1.0', Pakman::VERSION],
  ['fetcher',           '0.4.5', Fetcher::VERSION],
  ['feedparser',        '2.1.2', FeedParser::VERSION],
  ['feedfilter',        '1.1.1', FeedFilter::VERSION],
  ['textutils',         '1.4.0', TextUtils::VERSION],
  ['logutils',          '0.6.1', LogKernel::VERSION],
  ['props',             '1.2.0', Props::VERSION],

  ['pluto-models',      '1.5.4', Pluto::VERSION],
  ['pluto-update',      '1.6.3', PlutoUpdate::VERSION],
  ['pluto-merge',       '1.1.0', PlutoMerge::VERSION] )

pp outdated
```

Where the version check record entries are
1) the name, 2) the minimum requirement and 3) the used version
e.g. `Pluto::VERSION` will become at runtime `1.5.3` or something - depending
on the installation / setup.


If all libraries are up-to-date
this will result in an empty outdated list / array:

``` ruby
[]
```

And if some libraries are NOT matching the minimum requirement
the version record will get returned in the outdated list / array
resulting in, for example:

``` ruby
[['pluto-models',      '1.5.4', '1.5.3'],
 ['pluto-update',      '1.6.3', '1.4.1']]
```


Note: For the starter level
the version in use MUST always be greater or equal
to the minimum requirement version.

And the minimum requirement might be just a major (e.g. `2` same as `2.x.x`)
or a major plus minor (e.g. `2.1` same as  `2.1.x`) version.


To qualify for solving the code challenge / puzzle you must pass the test:


```ruby
require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test

  def test_version_check

    # 1) name, 2) minimum requirement, 3) used version
    versions_a =
    [['pakman',            '1.1.0', '1.1.1'],
     ['fetcher',           '0.4.5', '0.5.4'],
     ['feedparser',        '2.1.2', '2.2.1'],
     ['feedfilter',        '1.1',   '1.1.14'],
     ['textutils',         '2',     '2.0.5'],
     ['logutils',          '0.6',   '0.6.0'],
     ['props',             '1.2.1', '1.3.0'],

     ['pluto-models',      '1.5.4', '1.5.7'],
     ['pluto-update',      '1.6',   '2.0.0'],
     ['pluto-merge',       '1.1.0', '1.2.0']]

    versions_a_outdated = []

    versions_b =
    [['pakman',            '1.1.0', '1.0.1'],
     ['fetcher',           '0.4.5', '0.5.4'],
     ['feedparser',        '2.1.2', '2.2.1'],
     ['feedfilter',        '1.1',   '1.1.1'],
     ['textutils',         '2',     '1.2.7'],
     ['logutils',          '0.6',   '0.6.0'],
     ['props',             '1.2.1', '1.3.0'],

     ['pluto-models',      '1.5.4', '1.5.7'],
     ['pluto-update',      '1.6',   '1.5.11'],
     ['pluto-merge',       '1.1.0', '1.2.0']]

     versions_b_outdated =
     [['pakman',            '1.1.0', '1.0.1'],
      ['textutils',         '2',     '1.2.7'],
      ['pluto-update',      '1.6',   '1.5.11']]


    assert_equal versions_a_outdated,
                 version_check( versions_a )

    assert_equal versions_b_outdated,
                 version_check( versions_b )
  end
end
```


Start from scratch or, yes, use any library / gem you can find.

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy list processing and version checking with Ruby.

