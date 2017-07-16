# encoding: utf-8


module Texti

## split document in outline, that is,
##   headlines and text blocks
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




   ## table of contents from outline array
   ##   move to its own class - why? why not??

   class TreeNode
     attr_accessor :level
     attr_accessor :text
     attr_accessor :children

     def initialize( level, text, children=[] )
       @level    = level
       @text     = text
       @children = children
     end
   end # class TreeNode


   def self.toc( outline )

      ## get all headings (filter/select/skip everything else e.g. textblocks, etc.)
      headings = outline.select { |item| item[0][0] == ?= }
      pp headings

      ## convert to tree nodes
      headings = headings.map do |item|
        level = item[0].size   ## e.g. = is 1, == is 2, etc
        text  = item[1]
        node = TreeNode.new( level, text )
        node
      end
      pp headings


      ## start with root level 0 (empty stack [])
      root  = TreeNode.new( 0, '<root>', [] )
      stack = []
      stack.push( root )

      headings.each do |node|

          level_diff = node.level - stack.last.level

           if level_diff > 0
             puts "  [toc]    up  +#{level_diff}  - #{node.level}: >#{node.text}"
             ## FIX!!! todo/check/verify/assert: always must be +1

                current = stack.last
                puts "     adding node #{node.level}: >#{node.text}< to #{current.level}: #{current.text}"
                current.children << node
                stack.push( node )

           elsif level_diff < 0
             puts "  [toc]    down #{level_diff}  - #{node.level}: >#{node.text}"
             level_diff.abs.times { stack.pop }
             ### todo/fix: check if we pop too much - double check levels!!!! issue warning!!!

              current = stack.last
              puts "     adding node #{node.level}: >#{node.text}< to #{current.level}: #{current.text}"
              current.children << node
           else
             ## same level
             puts "  [toc]    =             - #{node.level}: >#{node.text}"

             current = stack.last
             puts "     adding node #{node.level}: >#{node.text}< to #{current.level}: #{current.text}"
             current.children << node
           end

           ### pp root

         end  # each headings

      root
    end # method toc

end # class Outline

end # module Texti
