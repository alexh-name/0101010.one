#!/bin/sh

FILE="${WSH_GENF_FINAL}"
echo "$WSH_GENF_FINAL"

TOC="$(
printf "%s\n" '<h2>ToC</h2>'
printf "%s\n" '<ul>'
  grep -F '<h2' "${FILE}" | \
  LC_ALL=C sed -e 's/h2/a/g' -e 's/id="/href="#/g' -e 's/^/<li>/g' \
    -e 's/$/<\/li>/g'
printf "%s\n" '</ul>'
)"

awk -v toc="${TOC}" '/<!--TOC-->/{sub(/<!--TOC-->/,toc)};{print}' \
  "${FILE}" > "${FILE}".tmp
mv "${FILE}".tmp "${FILE}"
