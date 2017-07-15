# encoding: utf-8


require 'yaml'
require 'json'
require 'date'
require 'pp'

# our own code
require 'texti/version'   # note: let version always go first
require 'texti/pattern'
require 'texti/parser'


# say hello
puts Texti.banner    if defined?( $RUBYLIBS_DEBUG )
