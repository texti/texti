# encoding: utf-8


module Texti

class MarkdownWriter



def markdown() @text; end

def html
  ### kramdown hack
  ##  escape | => \|   otherwise get turned into a table

  text = @text.gsub( /\|/, '\|' )

  Kramdown::Document.new( text ).to_html
end


def initialize( text )
  @outline = Outline.parse( text )
  @toc     = TableOfContents.from_outline( @outline )

  @text, @refs = ReferenceProc.convert( text )

  ##  todo:
  ## add footnote references add the end of the document

  @text = add_references( @text, @refs )


  ## change/convert headings
  @text = convert_headings( @text )
  @text = convert_emphasis( @text )   # bold / italics
end


def add_references( text, refs )

  text << "\n\n\n"

  refs.each_with_index do |ref,i|

    ## cutoff first value | (it's the reference name)
    pos = ref.index('|')
    if pos
      ref = ref[pos+1..-1]
    end
    ## strip all newlines / make it a single line
    ref = ref.strip
    ref = ref.gsub( /\n/, ' ' )
    ref = ref.gsub( /[ ]+/, ' ' )   # squis spaces to one

    text << "[^#{i+1}]: #{ref}\n"
  end

  text
end



def convert_emphasis( text )
   ## note: quick hack for now just search for ''' and ''

   ###  combined ''''' (5) will NOT work for now
   ##   fix/todo: ''''' will not work (will output **_ **_ instead of **_ _**)
   text.gsub( /'''|''/ ) do |match|
     puts "  match=|>#{match}<|"
     if match.size == 3
       "**"
     elsif match.size == 2
       "_"
     else
       ## issue error /throw exception (unknown heading, etc.)
       match
     end
   end
end

def convert_headings( text )

    ## wrap in (?:)  why? why not?
    ##    will pipe(|) bind to patter or just last term???

    text.gsub( /(?:#{HEADING3})|(?:#{HEADING2})|(?:#{HEADING1})/ox ) do |match|
      puts "  match=|>#{match}<|"
      m = Regexp.last_match
      if m[:heading1]
        puts "    !! bingo = (heading 1) |>#{m[:heading1]}<|"
        "# #{m[:heading1]} #\n\n"    ## add blank line after heading
      elsif m[:heading2]
        puts "    !! bingo == (heading 2) |>#{m[:heading2]}<|"
        "## #{m[:heading2]} ##\n\n"    ## add blank line after heading
      elsif m[:heading3]
        puts "    !! bingo === (heading 3) |>#{m[:heading3]}<|"
        "### #{m[:heading3]} ###\n\n"    ## add blank line after heading
      else
        ## issue error /throw exception (unknown heading, etc.)
        match
      end
    end
end # method convert_headings


end # class MarkdownWriter
end # module Texti
