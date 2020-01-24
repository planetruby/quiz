# Ruby Quiz - Challenge #16 - Build the Manuscripts Book Manifest for Documents in Markdown


Let's read documents in structured text with formatting conventions in markdown and build up the chapter outline / manifest
for the [Manuscripts
book format](http://manuscripts.github.io).

---
Aside: What's structured text in Markdown?

Markdown uses hashtags (`#`) for marking up headings. Example:

``` md
# Heading Level 1
## Heading Level 2
### Heading Level 3
#### Heading Level 4
...
```

or (using the real-world example from the [Yuki & Moto Press Bookshelf](http://yukimotopress.github.io/) used in this quiz)

``` md
# Hoe Developer's Guide
## What is Hoe?
## A Brief History of Hoe
## Why Use Hoe?
### Projects, the DRY way
### Update all your projects in 1 easy step
...
```

---



The challenge: Code a `build` method that passes the RubyQuizTest :-).

``` ruby
def build( txt )
  # ...
end
```

For the starter level 1 build up the Manuscripts book manifest
in the YAML format
for the [Hoe Developer's Guide - Build, Package and Publish Gems with Rake Tasks - Ready-to-Use Build Scripts by Ryan Davis et al](https://github.com/yukimotopress/gem-tasks) from the heading hierarchy in structured text in the markdown format. Turn:

``` md
# Hoe Developer's Guide
## What is Hoe?
## A Brief History of Hoe
## Why Use Hoe?
### Projects, the DRY way
### Update all your projects in 1 easy step
### New projects in 1 easy step
### Releasing in 1 easy step
### Noticing a pattern yet?
### Extensibility
## Creating a new Project
### From Scratch
### Using Sow Templates
## Work the Way You Want to Work
## Project Structure
## Extending Hoe with Plugins
### Using Hoe Plugins
### Popular Hoe Plugins
### Writing Hoe Plugins
### How Plugins Work
## Questions & Counterpoints
### "Why should I maintain a Manifest.txt when I can just write a glob?"
### "Why not just write gemspecs?"
### "What about (newgem|bones|echoe|joe|gemify|...)?"
```

(Note: All text stripped for clarity, that is,
making it clear to see the heading hierarchy / tree structure of the page.)

into:

``` yaml
- title: "Hoe Developer's Guide"
  sections:
  - title: What is Hoe?
  - title: A Brief History of Hoe
  - title: Why Use Hoe?
    sections:
    - title: Projects, the DRY way
    - title: Update all your projects in 1 easy step
    - title: New projects in 1 easy step
    - title: Run your tests in 1 easy step
    - title: Releasing in 1 easy step
    - title: Noticing a pattern yet?
    - title: Extensibility
  - title:  Creating a new Project
    sections:
    - title: From Scratch
    - title: Using Sow Templates
  - title: Work the Way You Want to Work
  - title: Project Structure
  - title: Extending Hoe with Plugins
    sections:
    - title: Using Hoe Plugins
    - title: Popular Hoe Plugins
    - title: Writing Hoe Plugins
    - title: How Plugins Work
  - title: "Questions & Counterpoints"
    sections:
    - title: Why should I maintain a Manifest.txt when I can just write a glob?
    - title: Why not just write gemspecs?
    - title: "What about (newgem|bones|echoe|joe|gemify|...)?"
```

Note: The test compares the parsed YAML as a standard array (of hashes) in ruby, thus,
you do NOT have to worry about matching quoted or unquoted strings
or extra spaces or newlines or comments.


Note: For easy reference and testing you can use the "local" page, see [`manuscript/index.md`](manuscript/index.md).


To qualify for solving the code challenge / puzzle you must pass the test:


```ruby
require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test
  def test_build
    txt      = File.open( "./manuscript/index.md",          "r:utf-8" ).read
    headings = File.open( "./manuscript/META/contents.yml", "r:utf-8" ).read

    assert_equal YAML.load( headings ),
                 YAML.load( build( txt ))
  end
end
```

Start from scratch or, yes, use any library / gem you can find.

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy book manufacturing and text processing with Ruby.

