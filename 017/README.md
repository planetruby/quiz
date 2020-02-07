# Ruby Quiz - Challenge #17 - Build an HTML Template Engine Like It's 1999


Remember the time before Facebook? It was all about blogs
and building your own newsfeed from blog rolls.

The most popular newsfeed tool in 1999 was called Planet
and used the HTML template language / engine.

Let's say you have the following blog roll / channels
defined in ruby:

``` ruby
Blogroll = Struct.new( :name, :owner_name, :date_822, :channels )
Channel  = Struct.new( :name, :url, :channel_link )

blogroll = Blogroll.new( 'OpenStreetMap Blogs',
                         'OpenStreetMap',
                          Date.new( 2020, 2, 7 ).rfc2822,
                         [Channel.new( 'Shaun McDonald',
                                       'http://blog.shaunmcdonald.me.uk/feed/',
                                       'http://blog.shaunmcdonald.me.uk/' ),
                          Channel.new( 'Mapbox',
                                       'https://blog.mapbox.com/feed/tagged/openstreetmap/',
                                       'https://blog.mapbox.com/' ),
                          Channel.new( 'Mapillary',
                                       'https://blog.mapillary.com/rss.xml',
                                       'https://blog.mapillary.com' ),
                          Channel.new( 'Richard Fairhurst',
                                       'http://blog.systemed.net/rss',
                                       'http://blog.systemed.net/' )]
                        )

pp blogroll
```

pretty printing to:

```
#<struct Blogroll
   name="OpenStreetMap Blogs",
   owner_name="OpenStreetMap",
   date_822="Fri, 7 Feb 2020 00:00:00 +0000",
   channels=
   [#<struct Channel
       name="Shaun McDonald",
       url="http://blog.shaunmcdonald.me.uk/feed/",
       channel_link="http://blog.shaunmcdonald.me.uk/">,
    #<struct Channel
       name="Mapbox",
       url="https://blog.mapbox.com/feed/tagged/openstreetmap/",
       channel_link="https://blog.mapbox.com/">,
    #<struct Channel
       name="Mapillary",
       url="https://blog.mapillary.com/rss.xml",
       channel_link="https://blog.mapillary.com">,
    #<struct Channel
       name="Richard Fairhurst",
       url="http://blog.systemed.net/rss",
       channel_link="http://blog.systemed.net/">]>
```

Let's build an HTML template engine like it's 1999.
Example:

```
<?xml version="1.0"?>
<opml version="1.1">
  <head>
    <title><TMPL_VAR name></title>
    <dateModified><TMPL_VAR date_822></dateModified>
    <ownerName><TMPL_VAR owner_name></ownerName>
  </head>

  <body>
    <TMPL_LOOP channels>
    <outline type="rss"
             text="<TMPL_VAR name>"
             xmlUrl="<TMPL_VAR url>"
             <TMPL_IF channel_link> htmlUrl="<TMPL_VAR channel_link>"</TMPL_IF> />
    </TMPL_LOOP>
  </body>
</opml>
```

In the starter level handle variables, conditionals, and loops.
Syntax overview:

**1) `<TMPL_VAR identifier>`**

```
<TMPL_VAR name>
<TMPL_VAR date_822>
```

**2) `<TMPL_IF identifier>..</TMPL_IF>`**

```
<TMPL_IF channel_link> htmlUrl="<TMPL_VAR channel_link>" </TMPL_IF>
```

**3) `<TMPL_LOOP identifier>..</TMPL_LOOP>`**

```
<TMPL_LOOP channels>
  <outline type="rss"
             text="<TMPL_VAR name>"
             xmlUrl="<TMPL_VAR url>"
             <TMPL_IF channel_link> htmlUrl="<TMPL_VAR channel_link>"</TMPL_IF> />
</TMPL_LOOP>
```

Note: Inside loops you have
to auto-add the loop context e.g. `channel` to make
variables or conditionals work e.g. `name`
becomes `[channel.]name` and `channel_link` becomes `[channel.]channel_link`
and so on.


The challenge: Code a `merge`
method that merges the passed in HTML template
and the blogroll into a merged XML document
that passes the RubyQuizTest :-).



``` ruby
def merge( template, blogroll )
  # ...
end
```

Resulting in:

``` xml
<?xml version="1.0"?>
<opml version="1.1">
  <head>
    <title>OpenStreetMap Blogs</title>
    <dateModified>Fri, 7 Feb 2020 00:00:00 +0000</dateModified>
    <ownerName>OpenStreetMap</ownerName>
  </head>

  <body>

    <outline type="rss"
             text="Shaun McDonald"
             xmlUrl="http://blog.shaunmcdonald.me.uk/feed/"
             htmlUrl="http://blog.shaunmcdonald.me.uk/" />

    <outline type="rss"
             text="Mapbox"
             xmlUrl="https://blog.mapbox.com/feed/tagged/openstreetmap/"
             htmlUrl="https://blog.mapbox.com/" />

    <outline type="rss"
             text="Mapillary"
             xmlUrl="https://blog.mapillary.com/rss.xml"
             htmlUrl="https://blog.mapillary.com" />

    <outline type="rss"
             text="Richard Fairhurst"
             xmlUrl="http://blog.systemed.net/rss"
             htmlUrl="http://blog.systemed.net/" />

  </body>
</opml>
```

Note: For the test the xml document gets automatically
reformatted
and pretty printed in compact style with two-space indent
so you do NOT have to worry about spaces, line breaks, quotes or indendation.
Reformatted example:

``` xml
<opml version='1.1'>
  <head>
    <title>OpenStreetMap Blogs</title>
    <dateModified>Fri, 7 Feb 2020 00:00:00 +0000</dateModified>
    <ownerName>OpenStreetMap</ownerName>
  </head>
  <body>
    <outline type='rss' text='Shaun McDonald' xmlUrl='http://blog.shaunmcdonald.me.uk/feed/' htmlUrl='http://blog.shaunmcdonald.me.uk/'/>
    <outline type='rss' text='Mapbox' xmlUrl='https://blog.mapbox.com/feed/tagged/openstreetmap/' htmlUrl='https://blog.mapbox.com/'/>
    <outline type='rss' text='Mapillary' xmlUrl='https://blog.mapillary.com/rss.xml' htmlUrl='https://blog.mapillary.com'/>
    <outline type='rss' text='Richard Fairhurst' xmlUrl='http://blog.systemed.net/rss' htmlUrl='http://blog.systemed.net/'/>
  </body>
</opml>
```


To qualify for solving the code challenge / puzzle you must pass the test:


```ruby
require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test
  Blogroll = Struct.new( :name, :owner_name, :date_822, :channels )
  Channel  = Struct.new( :name, :url, :channel_link )

  def blogroll
     Blogroll.new( 'OpenStreetMap Blogs',
                   'OpenStreetMap',
                    Date.new( 2020, 2, 7 ).rfc2822,
                   [Channel.new( 'Shaun McDonald',
                                 'http://blog.shaunmcdonald.me.uk/feed/',
                                 'http://blog.shaunmcdonald.me.uk/' ),
                    Channel.new( 'Mapbox',
                                 'https://blog.mapbox.com/feed/tagged/openstreetmap/',
                                 'https://blog.mapbox.com/' ),
                    Channel.new( 'Mapillary',
                                 'https://blog.mapillary.com/rss.xml',
                                 'https://blog.mapillary.com' ),
                    Channel.new( 'Richard Fairhurst',
                                 'http://blog.systemed.net/rss',
                                 'http://blog.systemed.net/' )]
                  )
  end

  def test_merge
    template      = File.open( "./opml/opml.xml.tmpl", "r:utf-8" ).read
    xml           = File.open( "./opml/opml.xml",      "r:utf-8" ).read

    assert_equal prettify_xml( xml ),
                 prettify_xml( merge( template, blogroll ))
  end


  ## xml helper
  def prettify_xml( xml )
      d = REXML::Document.new( xml )

      formatter = REXML::Formatters::Pretty.new( 2 )  # indent=2
      formatter.compact = true # This is the magic line that does what you need!
      pretty_xml = formatter.write( d.root, "" )
      pretty_xml
  end
end
```


Start from scratch or, yes, use any library / gem you can find.

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy text processing and template merging with Ruby.
