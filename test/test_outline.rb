# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_outline.rb


require 'helper'


class TestOutline < MiniTest::Test


  def xx_test_wikipedia

    text = File.open( "#{Texti.root}/test/data/wikipedia/Markup_language.texti", 'r:bom|utf-8' ).read

    puts text
    puts " ::::::::::::::::: "

    outline = Texti::Outline.parse( text )
    pp outline

    puts "table of contents:"
    toc = Texti::TableOfContents.from_outline( outline )
    pp toc
    pp toc.to_a

    assert true
  end

  def test_inline_toc

    text = <<TXT
=Heading1.a

some text here

== Heading 2.a

= Heading 1.b ======

some more text here
and some more

and some more and more

== Heading 2.b

===Heading 3

==Heading 2.c
TXT

    puts text
    puts " ::::::::::::::::: "

    outline = Texti::Outline.parse( text )
    pp outline

    puts "table of contents:"
    toc = Texti::TableOfContents.from_outline( outline )
    pp toc
    pp toc.to_a

    assert true
  end



  def xx_test_inline

    text = <<TXT
=Heading1.a

some text here

= Heading 1.b

= Heading 1.c ======

some more text here
and some more

and some more and more

== Heading 2

===Heading 3
=Heading 1.d
TXT

    puts text
    puts " ::::::::::::::::: "

    outline = Texti::Outline.parse( text )
    pp outline

    assert true
  end

end # class TestOutline
