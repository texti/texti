# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_markdown.rb


require 'helper'


class TestMarkdown < MiniTest::Test


  def test_wikipedia

    text = File.open( "#{Texti.root}/test/data/wikipedia/Markup_language.texti", 'r:bom|utf-8' ).read
    md = Texti::MarkdownWriter.new( text )

    puts " ::: Text ::::::::::::::::::::::::"
    puts md.text

    assert true
  end

end # class TestMarkdown
