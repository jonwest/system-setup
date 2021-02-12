#                              _            _    
#   _ __ ___   __ _  ___    __| | ___   ___| | __
#  | '_ ` _ \ / _` |/ __|  / _` |/ _ \ / __| |/ /
#  | | | | | | (_| | (__  | (_| | (_) | (__|   < 
#  |_| |_| |_|\__,_|\___|  \__,_|\___/ \___|_|\_\
#        _                                       
#    ___| | ___  __ _ _ __  _   _ _ __           
#   / __| |/ _ \/ _` | '_ \| | | | '_ \          
#  | (__| |  __/ (_| | | | | |_| | |_) |         
#   \___|_|\___|\__,_|_| |_|\__,_| .__/          
#                                |_|             

echo "Cleaning up dock..."

apps_to_remove=(
    'Siri'
    'Launchpad'
    'Mail'
    'Safari'
    'Calendar'
    'Contacts'
    'Notes'
    'Reminders'
    'Maps'
    'Photos'
    'Messages'
    'FaceTime'
    'Pages'
    'Podcasts'
    'TV'
    'Numbers'
    'Keynote'
    'News'
    'Music'
    'App Store'
    'System Preferences'
)

echo "Removing default bloat apps from dock..."
for app in "${apps_to_remove[@]}"; do
  eval 'sudo dockutil --remove "${app}" --no-restart' > /dev/null 2>&1
done

killall "Dock" > /dev/null 2>&1
