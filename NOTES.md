# Notes


## Todos

- [ ]  add parser for wikipedia '' conversion - why? why not?

- [ ]  add parser for {{ }} template syntax - allow nested templates is a MUST!!!

- [ ]  add parser for [] link syntax - allow nested links
     - used for footnots e.g. [^1 | [url] | hello etc.]  - why? why not?  



## Markdown

### back matter meta data block

(auto-)remove the meta data block in back matter - why? why not?

```
---
See also:
  - Comparison of document markup languages
  - Curl (programming language)
  - List of markup languages
  - Markdown
  - ReStructuredText
  - Programming language
  - Style language

Categories:
  - Markup languages
  - Formal languages
  - American inventions
---
```


### convert wikipedia external links
Convert in References (Footnotes) to Markdown Links - why? why not?

```
[^4]: Michael Downes. [http://www.ams.org/notices/200211/comm-downes.pdf "TEX and LATEX 2e"]
```


### footnotes

Might be better in "literal" form as is and not "hidden" as a link.


Check if github markdown supports footnotes (a la kramdown etc.).
Footnotes not working in <https://github.com/texti/texti/blob/master/test/data/wikipedia/Markup_language.md>


### definition lists

looks like definitions are not working too. see:

```
Presentational markup
:The kind of markup used by traditional word-processing systems: binary codes embedded within
document text that produce the [[WYSIWYG]] effect. Such markup is usually hidden from human
users, even authors or editors.
```

does not work for multi-line? or needs blank line??



## Alternative Liquid Syntax

Why?

:no:  `{{ }}` => used for page templates (includes)


```
<img src="{{$1}}">   
```

:no: $.$  => latex match mode 

```
<img src="$1$">       why not:  
```



Let's keep statements / tags e.g. `{% %}` - why? why not?

```
{%for category in page.categories%}   
...
{%endfor%}
```

`%`used for latex comments - `{%` is different enough to avoid confusion ??


Why not?

```
{§ for category in page.categories §}  --> already used for §1§  §page.title§ etc.  
...
{§ endfor §}

or

{> for category in page.categories <}   
...
{> endfor <}

or

{>for category in page.categories<}   
...
{>endfor<}

or

[>for category in page.categories<]   
...
[>endfor<]

or

[%for category in page.categories%]   
...
[%endfor%]

or

{| for category in page.categories |}   
...
{| endfor |}
```



### Alternative to `{{ }}`

Yes:

```
Use §1§                => mapped to {{  para1 }}
Use §page.title§       => mapped to {{  page.title }}
```


More:


```
  <img src="{=$1}">     -- {= ..}    too long ??
  <img src="{=#1}">     -- {= ..}    too long ??
  <img src="{=\1}">     -- {= ..}    too long ??
  <img src="[=$1]">   
  <img src="[=#1]">   

  <img src="#{$1}">
  <img src="#[$1]">     -- {= ..}    too long ??
  <img src="#{\1}">
  <img src="#[\1]">     -- {= ..}    too long ??
 

  <img src="{$1}">      -- {$num} {$id} shortcut/shortform - why? why not
  <img src="{#1}">      -- {$num} {$id} shortcut/shortform - why? why not
  <img src="§1§">       --  §num§  §id§ shortcut/shortform - why? why not

```

what to use for position paramters?

```
$1
#1
\1
§1
other?
```


```
  <img src="{=page.cover}"> 
  <img src="{= page.cover }"> 

  <img src="{$page.cover}">  
  <img src="{#page.cover}">  
  <img src="§page.cover§"> 

  <img src="[=page.cover]"> 

   <img src="#[page.cover]"> 
   <img src="#{page.cover}"> 

```

