#!/bin/bash

# Usage: ./translate-tailwind.sh [FILES]
#        - SPECIAL : Run without @base
# Example: ./translate-tailwind.sh index.html dashboard.html errors.html
# Example: SPECIAL=1 ./translate-tailwind.sh index.html dashboard.html errors.html

WORKING_DIRECTORY='/Users/username/Documents/Tools/TailwindKumo' # Current directory where this bash script is located.
DIRECTORY=$(pwd)

cd "$WORKING_DIRECTORY"

RED='\033[0;31m'
GRE='\033[0;32m'
END='\033[0m'

NEW="tailwind-out-$(date +%s).css"
OLD=''

for file in $@; do
	if [[ -f "$DIRECTORY/$file" ]]; then
		OLD=$(cat "$DIRECTORY/$file" | grep -oE 'tailwind-out-.*\.css')
		BASENAME=$(basename -- "$file")
		if [ ! -z "$OLD" ]; then
			sed -i '' -e "s/$OLD/$NEW/g" "$DIRECTORY/$file"
			if [[ -f "$DIRECTORY/$OLD" ]]; then
				rm "$DIRECTORY/$OLD"
			fi
		fi
		ln -s "$DIRECTORY/$file" "$WORKING_DIRECTORY/src/$(date +'%s')-$RANDOM-$BASENAME"
		printf "${GRE}[+] Operation success:${END} $file\n"
	else
		printf "${RED}[!] File not found:${END} $file\n"
	fi
done

if [ ! -z "$SPECIAL" ]; then
	npm run special
else
	npm run minify
fi

cp "$WORKING_DIRECTORY/public/output.css" "$DIRECTORY/$NEW" && cd "$WORKING_DIRECTORY/src" && ls | grep -v input.css | xargs rm
printf "${GRE}[+] Old tailwind script name:${END} $OLD\n"
printf "${GRE}[+] Operation success:${END} $NEW\n"
