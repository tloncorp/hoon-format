# Autoformatter for hoon

This is a basic autoformatter for hoon.  See the comments at the top of
format.hoon for a discussion of its implementation.

## Limitations

This is still very experimental.  The biggest weaknesses are:
- no comments (need parser to store them)
- core arms are in alphabetical order (need AST to store `(list [term
  hoon])` instead of `(map term hoon)`)
- no vertical alignment (requires some fancy lookahead, but should be
  doable locally)
- various hoons, specs, and skins are unimplemented

We do not propose enforcing this style anywhere.  There's a long way to
go before it could be suitable for that, if it ever will.  However, it
can be a useful pedagogical tool, as well as a description of typical
hoon style.  A useful mode of interaction would be to select some code
and press a key to autoformat it.  Even if you don't use the result, it
will clarify questions quickly.  An editor plugin for this would be very
nice, but even a sail page with a text box where you click submit and it
displays your code autoformatted would be great.

A useful exercise is to format this file with itself.  The only
concession we've made to make this easy is that we've ordered arms
alphabetically; the remainder is a very typical hoon style.  Use your
favorite diff tool, but if you're a vim user, open both files in two
columns and run `:diffthis` on both files to get an interactive diff.

This still lacks many runes.  Not all runes can be the direct result of
parsing, so it's not necessary to go through and implement everything in
+hoon.  A better strategy is to take real files and run them through
this, adding any missing runes and fixing any situations where it gives
bad formatting.

If you run into a missing rune (it will print out `%missing` along with
the name of the rune), please create an issue including a snippet of
code (or the whole file) which triggers the issue.  Or even better, take
a crack at implementing it yourself and make a PR.

## Usage

Copy format.hoon into `/gen` of a desk.  Use `|new-desk %format` if you
want to create a new one.  This file has no dependencies.  Then run with
`+format!format <your hoon AST>`.  For example:

```
+format!format !,  *hoon  (add 2 3)
+format!format (ream .^(@t %cx /=format=/gen/format/hoon))
```

## Policy

An autoformatter is a honeypot for bikeshedding.  The guiding philosophy
of this one is to duplicate "modern kernel style".  This is different in
different areas of the codebase.

In particular, this is *not* a venue for suggesting novel improvements
to current code style; it likely can be improved, but this isn't the
place for it.

For now, ~wicdev-wisryt (@philipcmonk) will make final decisions on the
code style that this tool produces.  This is MIT-licensed, so feel free
to fork if you feel strongly.

Some formatting decisions are highly context-dependent.  In general, if
the style is good, we should try to implement that even if it's fairly
complex.  To the degree possible, this tool should not "dumb down" your
formatting by making it more regular at the expense of making patterns
more obvious.  For example, vertical alignment is often desired.
