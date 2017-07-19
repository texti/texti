# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_liquid.rb


require 'helper'


class TestLiquid < MiniTest::Test


  def convert_placeholders( text )
    text.gsub( /§(?:<num>[1-9])§|§(?:<id>[a-zA-Z][a-zA-Z0-9_.]*)§/ ) do |match|
      m = Regexp.last_match
      if m[:num]
        "{{ params[#{m[:num].to_i-1}] }}"
      elsif m[:id]
        "{{ #{m[:id]} }}"
      else
        ## throw exception unknown format / immpossible path
        match   # return as is
      end
    end
  end

  def test_render

text =<<TXT
  hello {{ title }}
  hello §title§
  hello §1§
  This is just a paragraph §1.1
  see §a.1 - just literal text
  xxx§2§yyy works "embedded" too
TXT

    text = convert_placeholders( text )

    puts ":: Template :::::::::::::::::::: "
    puts text

    h = {'title' => 'My Title',
         'params' => ['Hello, from one',
                      'Hello, from two']
        }

    t = Liquid::Template.parse( text )

    puts ":: Text :::::::::::::::::::::::::::::::::: "
    puts t.render( h )

    assert true
  end

end # class TestLiquid
