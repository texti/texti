# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_reference.rb


require 'helper'


class TestReference < MiniTest::Test


  def test_ref

    text = File.open( "#{Texti.root}/test/data/wikipedia/Markup_language.texti", 'r:bom|utf-8' ).read

    puts text
    puts " ::::::::::::::::::"

    text, refs = Texti::ReferenceProc.convert( text )


    puts " ::: Text ::::::::::::::::::"
    puts text

    puts " ::: References ::::::::::::::::::"
    pp refs

    assert true
  end

end # class TestReference
