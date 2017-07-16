# encoding: utf-8


module Texti

class LatexWriter


def latex() @text;  end

def initialize( text )

  ## for now convert to markdown/kramdown
  @text = MarkdownWriter.new( text ).markdown

  ### kramdown hack
  ##  escape | => \|   otherwise get turned into a table
  @text = @text.gsub( /\|/, '\|' )

  @text = Kramdown::Document.new( @text ).to_latex
end


end # class LatexWriter
end # module Texti
