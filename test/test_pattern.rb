# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_pattern.rb


require 'helper'


class TestPattern < MiniTest::Test

  def test_brackets

 text = <<TXT
     [url]
     [[page]]
     [[[anchor]]]
TXT

###  add [text][ref] link pattern with ref
##       []()   link pattern
##     [^ref]  reference/footnote pattern
##   [ref]:    reference pattern  -- must start line


    pp Texti::SINGLE_BRACKET
    pp Texti::DOUBLE_BRACKET
    pp Texti::TRIPLE_BRACKET

    ## note:
    ##  order is important
    ##   first try triple, than double, than single

    text = text.gsub( /#{Texti::TRIPLE_BRACKET}|#{Texti::DOUBLE_BRACKET}|#{Texti::SINGLE_BRACKET}/x ) do |match|
      puts "  match=<#{match}>"
      m = Regexp.last_match
      if m[:single_bracket]
        puts "    !! bingo single_bracket >#{m[:single_bracket]}<"
      elsif m[:double_bracket]
        puts "    !! bingo double_bracket >#{m[:double_bracket]}<"
      elsif m[:triple_bracket]
        puts "    !! bingo triple_bracket >#{m[:triple_bracket]}<"
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
