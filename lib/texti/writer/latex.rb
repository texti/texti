# encoding: utf-8


module Texti

class LatexWriter


def latex() @text;  end

def initialize( text )

  ## for now convert to markdown/kramdown
  @text = MarkdownWriter.new( text ).markdown

  @text = Kramdown::Document.new( @text ).to_latex
end


end # class LatexWriter
end # module Texti
