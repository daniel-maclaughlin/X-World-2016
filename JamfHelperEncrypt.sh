#!/bin/bash
#JAMF Helper Script for X-World Presentation

#JAMF Helper location
HELPER=`/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "X World 2016" -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/FileVaultIcon.icns" -lockHUD -description "This machine needs to be encrypted, this will require a restart" -showDelayOptions "0, 300, 900, 1800" -button2 "Encrypt" -defaultButton 2`


echo "jamf helper result was $HELPER";


if [ "$HELPER" == "1" ]; then
jamf displayMessage -message "An error has occured please contact the IT Dept"
sudo killall afplay
else
if [ "$HELPER" == "2" ]; then
sudo jamf policy -trigger encrypt
sudo killall afplay
else
if [ "$HELPER" == "3002" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger encrypt" -name encrypt -minute '*/5/'
sudo killall afplay
if [ "$HELPER" == "9002" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger encrypt" -name encrypt -minute '*/15/'
sudo killall afplay
if [ "$HELPER" == "18002" ]; then
sudo jamf scheduledTask -command "/usr/local/jamf/bin/jamf policy -trigger encrypt" -name encrypt -minute '*/30/'
sudo killall afplay
fi
fi
fi
fi
fi
exit 0

