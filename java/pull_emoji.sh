#!/bin/sh
[ -f emoji_symbols.jl ] || curl -SOL https://raw.githubusercontent.com/JuliaLang/julia/master/stdlib/REPL/src/emoji_symbols.jl

# const emoji_symbols = Dict(
#     "\\:+1:" => "👍",

grep '^    "\\\\:' emoji_symbols.jl | cut -c 9- | sed -e 's/",$//' -e 's/" => "/\
/' | while read -r k && read -r v; do
	# printf 'new ShadowedCharSequence("%s", '\''%s'\''),\n' "$k" "$v"   # NB: Java char isn't actually a character, hence:
	printf 'mEmojis.put("%s", "%s".toCharArray());\n' "${k%:}" "$v"
done
