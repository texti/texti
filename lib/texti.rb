# encoding: utf-8


require 'yaml'
require 'json'
require 'date'
require 'pp'
require 'strscan'     # incl. StringScanner


## 3rd party
require 'kramdown'     # markdown and latex converter



# our own code
require 'texti/version'   # note: let version always go first
require 'texti/pattern'
require 'texti/parser'
require 'texti/template'
require 'texti/outline'
require 'texti/table_of_contents'
require 'texti/reference'
require 'texti/page'
require 'texti/writer/markdown'
require 'texti/writer/latex'


# say hello
puts Texti.banner    if defined?( $RUBYLIBS_DEBUG )
