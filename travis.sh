#!/bin/bash
RET=0
LANGUAGES=`wrc-languages`
for file in `git diff --name-only viroulep/travis`; do
  if [[ $file == */wca-regulations.md || $file == */wca-guidelines.md ]]; then
    echo "Detected change for file $file, running diff."
    wrc $file --diff wca-regulations-official
    RET=$(($RET+$?))
  fi
done
echo "================================="
BUILDDIR="build/"
for kind in html pdf; do
  for l in $LANGUAGES; do
    INPUTDIR=${l}
    BUILDDIR="build/translations/"${l}
    mkdir -p $BUILDDIR
    echo "Doing "${kind}" for language "${l}
    wrc --target=$kind -l $l -o $BUILDDIR $INPUTDIR
    RET=$(($RET+$?))
  done
  echo "================================="
done
exit $RET
