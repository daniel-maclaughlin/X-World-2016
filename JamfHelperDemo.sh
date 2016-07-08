#!/bin/bash
#JAMF Helper Script for X-World Presentation

#this is just for fun to enable audio
osascript -e 'set volume output volume 50'

file="/tmp/jeopardy.mp4"

#if else statment to check in the audio file is already downloaded, if not then downloadit
if [ -f "$file" ]
then
	afplay /tmp/jeopardy.mp4 &
else
	curl -k -L --silent --retry 5 -o /tmp/jeopardy.mp4 https://www.dropbox.com/s/whkwk3v670uug6h/Jeopardy.mp4?dl=1
	afplay /tmp/jeopardy.mp4 &
fi

#JAMF Helper location
HELPER=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "X World 2016 - JAMF Jeopardy" -icon "/Library/Desktop Pictures/xworld.png" -description "Welcome to X-World 2016, would you like to play a game?" -alignDescription center -button2 "Jeopardy" -button1 "Maybe Later" -defaultButton 2`

echo "jamf helper result was $HELPER";


if [ "$HELPER" == "0" ]; then
jamf displayMessage -message "Ok we'll try again later"
sudo killall afplay

else
if [ "$HELPER" == "1" ]; then
jamf displayMessage -message "Something went wrong, please try again or call IT"
sudo killall afplay

else
if [ "$HELPER" == "2" ]; then
jamf displayMessage -message "I'll take Clustering for 300 Alex"
sudo killall afplay
fi
fi
fi
exit 0