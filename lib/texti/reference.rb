# encoding: utf-8


module Texti

# reference (footnotes/endnotes/notes) processor
class ReferenceProc

def self.convert( text )
  self.new( text ).convert
end

def initialize( text )
  @text = text
end


def parse_reference
  if @buffer.peek(2) == '[^'
    @buffer.getch   ## consume [^
    @buffer.getch

    ref = ''
    stack = []
    loop do
      ## everything except [] -note: must add newline too (not include in [^])
      run = @buffer.scan( /[^\[\]]*/ )
      puts "    ref run is >#{run}<"
      ref << run

      if @buffer.peek(1) == ']' && stack.size == 0
        @buffer.getch  ## consume ]
        break
      elsif @buffer.peek(2) == '[['
        puts "    ref nested  [[ (#{stack.size})"
        ref << @buffer.getch  ## consume [[
        ref << @buffer.getch
        stack.push( '[[' )
      elsif @buffer.peek(1) == '['
        puts "    ref nested  [ (#{stack.size})"
        ref << @buffer.getch  ## consume [
        stack.push( '[' )
      ## note: must match!! [[]]
      ##  others [^1|[http://example.com, hello]]  - leads to trouble!!!!
      ##   addd stack.last.size check!!!
      elsif @buffer.peek(2) == ']]' && stack.last.size == 2
        ref << @buffer.getch  ## consume ]]
        ref << @buffer.getch
        stack.pop
        puts "    ref nested  ]] (#{stack.size})"
        ## check if matching e.g. '[[' !!!
      elsif @buffer.peek(1) == ']' && stack.last.size == 1
        ref << @buffer.getch  ## consume ]
        stack.pop
        puts "    ref nested  ] (#{stack.size})"
        ## check if matching e.g. '[' !!!
      else
        puts "!! format error: reference - unexpected square bracket - rest is >>#{@buffer.rest}<<"
      end
    end # loop
    puts "  bingo!! reference >#{ref}<"
    ref   ## return ref
  else
    ## todo/fix: throw exception or format error??
  end
end # method parse_reference


def convert
  @buffer = StringScanner.new( @text )
  @out    = ''
  @refs   = []


  loop do
    break if @buffer.eos?

    if @buffer.peek(2) == '[^'
      ref = parse_reference
      ## replace with a anchor reference link for now
      ##   use a reference @ref{1} makro or something in the future
      ref_count = @refs.size+1
      ## @out << "[ref_count][#ref#{ref_count}]"
      @out << "[^#{ref_count}]"
      @refs << ref
    else
      puts "scan until from #{@buffer.pos}"
      ### todo/fix:
      ##  eheck why it can't parse leading newline follow by [?? e.g.
      ##      "\n[[Brian Reid (computer scienti"
      ##
      ##  special case need for the rest - without any [^ - why can matched by lookahed?

      found = @buffer.exist?( /\[\^/ )
      puts "   scan rest - found >#{found.inspect}< for next ref"
      if found   ## still [^ present
         @out << @buffer.scan_until( /(?=\[\^)/ )     ## note: needs escpape ^ too
         puts "   scan rest is #{@buffer.rest[0..30].inspect}"
      else
         @out << @buffer.rest  ## scan until the end
         break   ## done
      end
    end
  end

  [@out, @refs]
end # method parse


end # class ReferenceProc
end # module Texti
