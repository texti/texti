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
Use §1§                => mapped to {{ \1 }} or {{ params[0] }}  -- \1 => params[0]
Use §page.title§       => mapped to {{ page.title }}
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
§1    -- use §1§ short form for §= \1 §
other?
```


```
  <img src="{=page.cover}"> 
  <img src="{= page.cover }"> 

  <img src="{$page.cover}">  
  <img src="{#page.cover}">  
  <img src="§page.cover§"> 
  <img src="§=page.cover§"> 
  <img src="§= page.cover §"> 

  <img src="[=page.cover]"> 

   <img src="#[page.cover]"> 
   <img src="#{page.cover}"> 

```


long format with filters

```
{{ page.people | group_by: "school" }}

§[ page.people | group_by: "school" ]§     §[ \1 ]§

§= page.people | group_by: "school" §      §= \1 §
§< page.people | group_by: "school" >§     §< \1 >§
§{ page.people | group_by: "school" }§     §{ \1 }§

§< page.people | group_by: "school" >
§[ page.people | group_by: "school" ]
§{ page.people | group_by: "school" }


§page.people | group_by: "school"§   -- allow spaces and quotes ???


{§ page.people | group_by: "school" §}   -- confusion with statement ??
```

### Examples

Wikipedia Categories

Original:

```
{% for category in categories %}
  [[Category:{{category}}]]
{% endfor %}
```

Alt Synatx I:

```
{% for category in categories %}
  [[Category:§category§]]
{% endfor %}
```

```
[% for category in categories %]
  [[Category:§category]]
[% endfor %]
```

```
[% for category in categories %]
  [[Category:§{category}§]]
[% endfor %]
```


```
%{ for category in categories }%
  [[Category:§category]]
%{ endfor }%
```

```
{% for category in categories %}
  [[Category:§[ category ]§]]
{% endfor %}
```


```
%{ for category in categories }%
  [[Category:§{category}§]]
%{ endfor }%
```

```
{% raw %}{% endraw %}{% raw %}{% endraw %}
%{ raw }%%{ endraw }%%{ raw }%%{ endraw }%
%{ raw }% %{ endraw }% %{ raw }% %{ endraw }%
```

```
§1§§2§§3§
§1§~§2§~§3§        =>  §[ \1 \2 \3 ]§ => §[ params[0] + parmas[1] + params[2] ]§
§1§ §2§ §3§
§1§2§3
§[\1]§[\2]§[\3]
§[\1]§§[\2]§§[\3]§

[§\1§][§\2§][§\3§]
[§1§][§2§][§3§]       => why not -- cannot match [[]] e.g. [[[§1§]]] - triple or double link ??? [[§1§]] or [[§[\1]§]]

§1234              
§{1}2345

§category§1  ~~§category§~~§1§   ~~~ optional invisible spacer!!! (for pretty printing - why? why not? only allowed beetween §.§~§.§ only allow one ?? use two (double for escaping ~)
§{category}1
§{category}§~~~1
```


