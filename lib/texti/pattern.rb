# encoding: utf-8


module Texti

  #################################
  ##### single quotes e.g. ''''

  ###
  ## 1=single
  ## 2=double
  ## 3=triple
  ## 4=quadruple
  ## 5=quintuple / pentadruple


   ##  ''..''       2 (2x2= 4)  ''''
   ##  '''..'''     3 (3x2= 6)  ''''''
   ##  '''''..''''' 5 (5x2=10)  ''''''''''


   ####
   ## todo/fix:
   ##   change [^']  to use new ruby negation in 2.4 ???
   ##     check article by what's new in ruby 2.4 ?? by ruby weekly author
   ##   or use lookahead ????

   ##
   ##   todo/check: does wikipedia markup allow unescaped (') inside quotes??


   ##   '' and ''' can get nested!!!!!!
   ##   add example here ???
   ##
   ##   thus: can't get matched at once with regex (use a parser!!!!!)
   ##     note: for now just start with scan for 5, than 3, than 2 for search/replace


   ## NOTE: will NOT match empty double single quotes (like an empty string)
   ##         at least one non-quote for content needed!!!!
   ##          e.g. pattern use ()+  -- instead of ()*


   ## e.g. '' for italics / emphasis
   DOUBLE_SINGLE_QUOTE = %< '' (?<double_single_quote>
                                (?:
                                  \\\\. | [^']
                                )+
                            )
                            ''
                        >

   ## e.g. ''' for bold / strong emphasis
   TRIPLE_SINGLE_QUOTE  = %< ''' (?<triple_single_quote>
                                   (?:
                                     \\\\. | [^']
                                   )+
                               )
                               '''
                           >

   ## e.g. ''''' for italics+bold / combined emphasis (strong emphasis+emphasis)
   QUINTUPLE_SINGLE_QUOTE = %< ''''' (?<quintuple_single_quote>
                                   (?:
                                     \\\\. | [^']
                                   )+
                               )
                               '''''
                           >



########
##
##

    SINGLE_BRACKET = %< \\[ (?<single_bracket>
                               [^\\]]+
                            )
                        \\]
                      >

    DOUBLE_BRACKET = %< \\[{2} (?<double_bracket>
                                 [^\\]]+
                               )
                        \\]{2}
                      >

    TRIPLE_BRACKET = %< \\[{3} (?<triple_bracket>
                                 [^\\]]+
                               )
                        \\]{3}
                      >


end # module Texti
