#!/bin/sh

[ -n "$1" ] && PHP="$1" || PHP=php
$PHP yellow.php generate

cd public
for file in $(grep -Rl '<!DOCTYPE html>' | grep -v '.html$'); do
    echo -n "Fixing $file:"
    mv $file $file.html
    for file2 in $(grep -Rl 'href="/'"$file"'"'); do
        sed 's@href="/'"$file"'"@href="/'"$file"'.html"@g' "$file2" > "$file2.tmp"
        mv "$file2.tmp" "$file2"
        echo -n " $file2"
    done
    echo ""
done
cd ..
