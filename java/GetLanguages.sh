#!/bin/sh

getLangsForFiles () {
	echo "en"  # default language
	for F in "$@"
	do
		find res/ -name "$F"
	done \
	| sed -n '
            s/.*res.[a-z]*-\(..\)-r\(..\).*/\1_\2/p; # yy-rXX => yy_XX
            s/.*res.[a-z]*-\(..\)\/.*/\1/p; # yy => yy
        '
}

getLangsForDicts () {
	(cd ../Dicts && printf '%s\n' *) | sed 's/.*-//; s/.dict//'
}

makeStrings () {
	Name="$1"
	shift
	echo "    private static final String[] $Name = {"
	printf '        "%s",\n' "$@" | sort -u
	echo "    };"
	echo
}

LOCS=$(getLangsForFiles donottranslate-altchars.xml donottranslate-keymap.xml kbd_qwerty.xml strings.xml)
DICTS=$(getLangsForDicts)

makeStrings KBD_LOCALIZATIONS $LOCS $DICTS

makeStrings KBD_5_ROW $(getLangsForFiles donottranslate-keymap.xml)

makeStrings KBD_4_ROW $(getLangsForFiles kbd_qwerty.xml)
