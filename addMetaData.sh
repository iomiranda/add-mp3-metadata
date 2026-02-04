#!/bin/bash
# Script to add meta data to my mp3 files
# File names need to be in format:
#	{Artist} - {Album} - {##} {Track}.mp3


echo "Beg of script..."

for x in *.mp3; do

    if [ -f "$x" ]; then
		
		IFS=' - ' read -r -a array <<< "$x"

		# Add Artist
		eyeD3 -a "${array[0]}" "$x"
        echo "Set title for '$x' to '{array[0]}'"
		
		# Add Album
		eyeD3 -A "${array[1]}" "$x"
        echo "Set title for '$x' to '{array[1]}'"
				
		# Split Track number with Song Title
		FULLSTRING = "${array[2]}"
		TRACKNUM = "$(FULLSTRING:0:2)"
		TRACKTITLE = "$(FULLSTRING:3)"
		
		# Add Track number
		eyeD3 -n "${TRACKNUM}" "$x"
        echo "Set track number for '$x' to '${TRACKNUM}'"

		# Add Song Title
		eyeD3 -t "${TRACKTITLE%.*}" "$x"
        echo "Set title for '$x' to '${TRACKTITLE%.*}'"

		IFS=$' \t\n'	
    fi
done

# Add Album cover art
# Needs to be outside of for loop

echo "End of script..."
