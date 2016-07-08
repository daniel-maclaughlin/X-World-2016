#!/bin/bash
#JAMF Helper Script for X-World Presentation


#JAMF Helper location
HELPER=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "X World 2016" -icon "/System/Library/CoreServices/Software Update.app/Contents/Resources/SoftwareUpdate.icns" -lockHUD -description "We have some important updates to install THIS WILL REQUIRE A REBOOT!!!! " -showDelayOptions "0, 300, 900, 1800" -button1 "YES" -button2 "NO" -defaultButton 1 -cancelButton 2`


echo "jamf helper result was $HELPER";


if [ "$HELPER" == "2" ]; then
jamf displayMessage -message "But the machine needs updates"
sudo killall afplay
else
if [ "$HELPER" == "1" ]; then
sudo jamf policy -trigger sus
sudo killall afplay
else
if [ "$HELPER" == "3001" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger sus" -name sus -minute '*/5/'
sudo killall afplay
if [ "$HELPER" == "9001" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger sus" -name sus -minute '*/15/'
sudo killall afplay
if [ "$HELPER" == "18001" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger sus" -name sus -minute '*/30/'
sudo killall afplay
fi
fi
fi
fi
fi
exit 0

