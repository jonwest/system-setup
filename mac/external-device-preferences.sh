#             _                        _                 
#    _____  _| |_ ___ _ __ _ __   __ _| |                
#   / _ \ \/ / __/ _ \ '__| '_ \ / _` | |                
#  |  __/>  <| ||  __/ |  | | | | (_| | |                
#   \___/_/\_\\__\___|_|  |_| |_|\__,_|_|                
#       _            _                                   
#    __| | _____   _(_) ___ ___                          
#   / _` |/ _ \ \ / / |/ __/ _ \                         
#  | (_| |  __/\ V /| | (_|  __/                         
#   \__,_|\___| \_/ |_|\___\___|                         
#                   __                                   
#   _ __  _ __ ___ / _| ___ _ __ ___ _ __   ___ ___  ___ 
#  | '_ \| '__/ _ \ |_ / _ \ '__/ _ \ '_ \ / __/ _ \/ __|
#  | |_) | | |  __/  _|  __/ | |  __/ | | | (_|  __/\__ \
#  | .__/|_|  \___|_|  \___|_|  \___|_| |_|\___\___||___/
#  |_|                                                   

echo "Setting up external device preferences...\n\n"

echo "Preventing Photos from opening automatically when devices are plugged in..."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Preventing Time Machine from prompting to use new hard drives as backup volume..."
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
