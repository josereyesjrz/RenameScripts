#!/usr/local/bin/bash

regex='([0-4])([0-9]{2}) (.*)'
mFiles='*.mkv'
mRegex='[0-9]{2} (.*)\.mkv'
while read ep || [[ -n "$ep" ]]
do
    if [[ $ep =~ $regex ]]
    then
        series="${BASH_REMATCH[1]}"
        epNo="${BASH_REMATCH[2]}"
        epName="${BASH_REMATCH[3]}"
        for m in $mFiles
        do
            if [[ $m =~ $mRegex ]]
            then
                oldName=${BASH_REMATCH[1]}
                stripEpName=${epName//[^[:alnum:]]/}
                stripOldName=${oldName//[^[:alnum:]]/}
                if [[ ${stripOldName,,} == ${stripEpName,,} ]]
                then
                    echo "$series""x""$epNo $epName"".mkv"
                    mv "$m" "$series""x""$epNo $epName"".mkv"
                fi
            else
                echo "$m doesn't match" >&2
            fi
        done
    else
        echo "new $ep doesn't match" >&2
    fi
done <"dwd order.txt"