# encoding: utf-8


require 'yaml'
require 'json'
require 'date'
require 'pp'
require 'strscan'     # incl. StringScanner

# our own code
require 'texti/version'   # note: let version always go first
require 'texti/pattern'
require 'texti/parser'
require 'texti/template'
require 'texti/outline'


# say hello
puts Texti.banner    if defined?( $RUBYLIBS_DEBUG )
