# encoding: utf-8

module Texti

   ## table of contents from outline array

  class TableOfContents

    class TreeNode     ## todo/check: rename to ContentNode or something??
      attr_accessor :level
      attr_accessor :text
      attr_accessor :children

      def initialize( level, text, children=[] )
        @level    = level
        @text     = text
        @children = children
      end

      def to_a
        [level, text, children.map { |it| it.to_a }]
      end
    end # class TreeNode


    def self.from_outline( outline )

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
           elsif level_diff < 0
             puts "  [toc]    down #{level_diff}  - #{node.level}: >#{node.text}"
             level_diff.abs.times { stack.pop }
             stack.pop    ## note: remove same level from stack (gets replaced w/ this one)
             ### todo/fix: check if we pop too much - double check levels!!!! issue warning!!!
           else
             ## same level
             puts "  [toc]    =             - #{node.level}: >#{node.text}"
             stack.pop    ## note: remove same level from stack (gets replaced w/ this one)
           end

           current = stack.last
           puts "     adding node #{node.level}: >#{node.text}< to #{current.level}: #{current.text}"
           current.children << node
           stack.push( node )

           ### pp root

         end  # each headings

      root
    end # method from_outline

end # class TableOfContents
end # module Texti
