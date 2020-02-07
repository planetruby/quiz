require 'date'
require 'rexml/document'

require 'minitest/autorun'



def merge( template, blogroll )
  # ...
end


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
      formatter.write( d.root, '' )
  end
end
