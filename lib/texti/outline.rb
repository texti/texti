# encoding: utf-8


module Texti

## split document in outline, that is,
##   headings and textblocks
##  e.g.
##  [
##    ['h1', ..],
##    ['text', ..],
##   ['h2', ..]
##   etc.
##  ]


class Outline

   def self.parse( text )
     self.new( text ).parse
   end

   def initialize( text )
     @text = text
   end



   def parse_heading
     if @buffer.peek(1) == '='
       level = @buffer.scan(/=+/)    ## get all equals
       @buffer.skip( /[ ]+/ )  ## skip space (only - NOT newlines!!)

       # note: use non-greedy e.g.+?  (min/first match)
       text  = @buffer.scan( /[^=]+?(?=[ ]*=*\n)/ )
       @buffer.skip( /[ ]*=*\n/ )   ## skip trailing space, markers and newline

       puts "  heading #{level}: |>#{text}<|"
       @out << [level,text]   ## e.g. ['==', 'Headline 2']
     end
   end  # method parse_heading



   def parse_textblock
     if @buffer.peek(1) == '='
        puts "!! format error: textblock - unexpected heading marker (=) - rest is >>#{@buffer.rest}<<"
     else
       text = ''
       loop do
         line = @buffer.scan( /^[^\n]*(\n|$)/ )  ## get new line (with newline) - is there a better regex??
         puts "    adding line: |>#{line.strip}<|"
         text << line
         break if @buffer.eos? || @buffer.peek(1) == '='
       end

       ##########
       ## note: strip leading and trailing whitespaces (incl. newlines)
       ##
       ##   fix:
       ##     only strip blank lines!!!
       ##       if textblock is an indented block -first indentation gets stripped tooo!!!!
       ###############

       text = text.strip
       ## check if all blank?
       if text == ''
          puts "  skipping blank textblock: |>#{text}<|"
       else
          puts "  textblock: |>#{text}<|"
          @out << ['text', text]
       end
     end
   end  # method parse_textblock


   def parse
     @buffer = StringScanner.new( @text )
     @out = []

     loop do
       break if @buffer.eos?

       if @buffer.peek(1) == '='
         parse_heading
       else
         parse_textblock
       end
     end

     @out
   end # method parse

end # class Outline

end # module Texti
