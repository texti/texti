# encoding: utf-8


module Texti

class Template

 def initialize( text, name:'?', format:'?', man:nil )
   @text     = text
   @name     = name
   @format   = format     ## check if format is a special ruby variable name???


   ## template manager to use (for recursive templates)
   ##  check/todo: pass in in render via context (ctx) or options - why? why not??
   @man      = man   # change to owner? store? collection? why? why not?
 end


 def render( args=[], opts={} )
   puts "  render template >#{@name}< [.#{@format}] with args:"
   pp args

  text = @text.gsub( /#{DOUBLE_CURLY_BRACKET}/x ) do |match|
      puts "  match=<#{match}>"
      m = Regexp.last_match
      if m[:double_curly_bracket]
        puts "    !! bingo double {{..}} >#{m[:double_curly_bracket]}<"

        ## remove leading and trailing spaces (and spaces between separator (|)
        values=m[:double_curly_bracket].strip.split( /\s*\|\s*/)
        pp values
        ## tryp to find template
        t = @man.fetch( values[0] )
        puts t.render( values[1..-1] )
      else
      end

      match
    end

    puts text

    text
 end

end # class Template



class TemplateMan   # Template manager / finder

  def initialize( roots=[] )
    @roots  = []
    @roots  += roots
    @roots  += [ "#{Texti.root}/data" ]   ## add built-in fallback

    pp @roots
  end

  def build( text, name:'<inline>', format:'html' )
    ##  todo: check if we can add timestamp to <inline> - use a different name - why? why not??
    t = Template.new( text, name:name, format:format, man:self )
    t
  end


  def fetch( name, format: 'html' )

    @roots.each do |root|
       path = "#{root}/#{name}.#{format}"
       print "  check >#{path}<..."
       if File.exist?( path )
         print " OK\n" ## not found
         text = File.open( path, 'r:bom|utf-8' ).read
         t = Template.new( text, name:name, format:format, man:self )
         return t
       else
         print " -X-\n" ## not found
       end
    end

    puts "!!! template >#{name}< [.#{format}] not found in root paths: #{@roots.inspect}"
    exit 1
  end # method fetch


end # class TemplateMan

end # module Texti
