#!/bin/bash
RET=0
for file in `git diff --name-only viroulep/travis`; do
  if [[ $file == */wca-regulations.md || $file == */wca-guidelines.md ]]; then
    echo "Detected change for file $file, running diff."
    wrc $file --diff wca-regulations-official
    RET=$(($RET+$?))
  fi
done
exit $RET
