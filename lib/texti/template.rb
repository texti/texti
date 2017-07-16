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


  def fetch( name, format:'html' )

    @roots.each do |root|

       ## check with (_) underscore first
       ##  todo/fix: auto-add /_ to roots - why? why not? more generic?
       ##   add flags e.g. for builtin - no checkin for _ for builtin only for "custom"??

       path1 = "#{root}/_#{name}.#{format}"
       path2 = "#{root}/#{name}.#{format}"
       path  = nil

       print "  check >#{path1}<..."
       if File.exist?( path1 )
         print " OK\n" ## not found
         path = path1
       else
         print " -X-\n" ## not found
         print "  check >#{path2}<..."
         if File.exist?( path2 )
           print " OK\n" ## not found
           path = path2
         else
           print " -X-\n" ## not found
         end
       end

       if path
         text = File.open( path, 'r:bom|utf-8' ).read
         t = Template.new( text, name:name, format:format, man:self )
         return t
       end
    end

    ## special case: for markdown try html as fallback
    if format == 'markdown'
      t = fetch( name, format:'html' )
      return t  if t
    end

    puts "!!! template >#{name}< [.#{format}] not found in root paths: #{@roots.inspect}"
    ### todo/fix: return nil
    exit 1
  end # method fetch


end # class TemplateMan

end # module Texti
