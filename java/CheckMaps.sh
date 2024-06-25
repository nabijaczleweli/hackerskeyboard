#!/bin/sh

Res=res/
Alt=donottranslate-altchars.xml
Map=donottranslate-keymap.xml

Out=assets/kbd/
mkdir -p "$Out"

for Dir in res/values res/values-*
do
  [ -f "$Dir/$Map" ] || continue # -o -f $Dir/$Alt ] || continue
  set -- "$Res/values/$Alt"
  [ -f "$Dir/$Alt" ] && set -- "$@" "$Dir/$Alt"
  set -- "$@" "$Res/values/$Map"
  [ -f "$Dir/$Map" ] &&   set -- "$@" "$Dir/$Map"
  if [ -n "$CONVERT_MAPS" ]; then
    Loc=$(printf '%s' "$Dir" | sed 's/res.values-*//; s/\/$//; s/^$/en/')
    perl CheckMap.pl -c "$@" > "$Out/map-full-$Loc.txt"
  else
    printf '%s: ' "$Dir"
    perl CheckMap.pl "$@"
  fi
done
