# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_latex.rb


require 'helper'


class TestLatex < MiniTest::Test


  def test_wikipedia

    text = File.open( "#{Texti.root}/test/data/wikipedia/Markup_language.texti", 'r:bom|utf-8' ).read
    tex = Texti::LatexWriter.new( text )

    puts " ::: Text ::::::::::::::::::::::::"
    puts tex.latex

    ##### save to disk
    ##  comment/uncomment for usage
    ## File.open( "#{Texti.root}/test/data/wikipedia/Markup_language.latex", 'w:utf-8' ) do |f|
    ##  f.write tex.latex
    ## end

    assert true
  end

end # class TestLatex
