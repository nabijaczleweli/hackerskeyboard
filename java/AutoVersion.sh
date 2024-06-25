#!/bin/sh

OUT=res/values/auto-version.xml

# TODO(klausw): check for uncommitted files?

Id="$(git describe --tags)"

Ver="$Id $(date +%Y-%m-%d)"

if [ ."$1" = ."reset" ]; then
  Ver="custom"
else
  echo "*** Version: $Ver"
fi

# Create the auto-version file with this version string
printf '%s\n''<?xml version="1.0" encoding="utf-8"?>' \
              '<!-- Auto-generated file, do not edit -->' \
              '<resources xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2">' \
              '   <string name="auto_version">'"$Ver"'</string>' \
              '</resources>' > $OUT
