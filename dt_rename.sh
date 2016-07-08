#!/usr/local/bin/bash

files='*.avi*'
regex='([1-4]x[0-9]{2}) - (.*)\.avi\.?p?a?r?t?'
mFiles='*.mkv'
mRegex='[1-2]x[0-9]{3} (.*)\.mkv'
for f in $files
do
    if [[ $f =~ $regex ]]
    then
        epNo=${BASH_REMATCH[1]}
        epName=${BASH_REMATCH[2]}
        for m in $mFiles
        do
            if [[ $m =~ $mRegex ]]
            then
                if [[ ${BASH_REMATCH[1]} == $epName ]]
                then
                    echo "$epNo ${BASH_REMATCH[1]}.mkv"
                    mv "$m" "$epNo ${BASH_REMATCH[1]}.mkv"
                fi
            else
                echo "RUSSIAN $m doesn't match" >&2
            fi
        done

    else
        echo "$f doesn't match" >&2
    fi
done