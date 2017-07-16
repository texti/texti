# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_pattern.rb


require 'helper'


class TestPattern < MiniTest::Test

  def test_curly_brackets

###
##  todo:
##    check multi-line match too !!!!
##
##

 text = <<TXT
     {{ fig | test.png }}
     {{ fig | test.png | width=200 }}
     {{ fig }}
     {{fig}}
     {{ img | test.png | width=200 }}
     {{ hello }}
     {{ page }}
TXT


    pp Texti::DOUBLE_CURLY_BRACKET

    puts text

    roots = ['./test/data' ]
    man   = Texti::TemplateMan.new( roots )
    t = man.build( text )

    puts t.render

    assert true
  end



  def xx_test_square_brackets

 text = <<TXT
     [url]
     [[page]]
     [[[anchor]]]
TXT

###  add [text][ref] link pattern with ref
##       []()   link pattern
##     [^ref]  reference/footnote pattern
##   [ref]:    reference pattern  -- must start line


    pp Texti::SINGLE_SQUARE_BRACKET
    pp Texti::DOUBLE_SQUARE_BRACKET
    pp Texti::TRIPLE_SQUARE_BRACKET

    ## note:
    ##  order is important
    ##   first try triple, than double, than single

    text = text.gsub( /#{Texti::TRIPLE_SQUARE_BRACKET}|#{Texti::DOUBLE_SQUARE_BRACKET}|#{Texti::SINGLE_SQUARE_BRACKET}/x ) do |match|
      puts "  match=<#{match}>"
      m = Regexp.last_match
      if m[:single_square_bracket]
        puts "    !! bingo single [..] >#{m[:single_square_bracket]}<"
      elsif m[:double_square_bracket]
        puts "    !! bingo double [[..]] >#{m[:double_square_bracket]}<"
      elsif m[:triple_square_bracket]
        puts "    !! bingo triple [[[..]]] >#{m[:triple_square_bracket]}<"
      else
      end

      match
    end

    puts text

    assert true
  end


  def xx_test_single_quotes

 ## note: for now nested version needs spaces

 text = <<TXT
  ''1italics''
  '''2bold'''
  '''''3combined'''''
  ''4italics '''4bold inside''' ''    # will not work?? e.g. ** -
  '''5bold ''5italics inside'' '''   # or without space ??
  '''6bold ''6italics inside'''''    # possible without any space ??
  '''7bold''7italics inside'''''     # => bolditalics inside ???
TXT

##
##  check: if allows '''' inside word ??
##  check if markdown allows ** inside word ???
##  in markdown _ is NOT recommended (best not used) inside word
##
##   does **bold _italic_ ** bold work ?? or just
##        **bold _italic_**  or
##        **bold_italic_**  or   ???

##
##  ''''''' combined
##   trivia - what order ?  italics first? followed by bold or
##                             bold followed by italics - does it matter?


###
##    '''5bold ''5italics inside'' '''   # or without space ??
##    has '' quotes inside ''' -- allow up to two ???



  ## todo:
  ## check for nested bold inside italics
  ##   and italics inside bold

  text_md = <<TXT
    _italics_
    **bold**
    _**combined**_
    _italics **bold inside**_
    **bold _italics inside_**
TXT

   puts "pass 1:"

    text = text.gsub( /#{Texti::TRIPLE_SINGLE_QUOTE}/x ) do |match|
      puts "  match=<#{match}>"
      m = Regexp.last_match
      if m[:triple_single_quote]
        puts "    !! bingo triple_single_quote >#{m[:triple_single_quote]}<"
        "**#{m[:triple_single_quote]}**"
      else
        match
      end
    end

    puts text

    assert true
  end

end # class TextPattern
