#                              _            _            
#   _ __ ___   __ _  ___    __| | ___   ___| | __        
#  | '_ ` _ \ / _` |/ __|  / _` |/ _ \ / __| |/ /        
#  | | | | | | (_| | (__  | (_| | (_) | (__|   <         
#  |_| |_| |_|\__,_|\___|  \__,_|\___/ \___|_|\_\        
#                   __                                   
#   _ __  _ __ ___ / _| ___ _ __ ___ _ __   ___ ___  ___ 
#  | '_ \| '__/ _ \ |_ / _ \ '__/ _ \ '_ \ / __/ _ \/ __|
#  | |_) | | |  __/  _|  __/ | |  __/ | | | (_|  __/\__ \
#  | .__/|_|  \___|_|  \___|_|  \___|_| |_|\___\___||___/
#  |_|                                                   

echo "Setting Dock preferences...\n\n"

# System Preferences > Dock > Size:
defaults write com.apple.dock tilesize -int 40

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool false

# System Preferences > Dock > Minimize windows using: Scale effect
defaults write com.apple.dock mineffect -string "scale"

# System Preferences > Dock > Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true

# System Preferences > Dock > Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.5

# System Preferences > Dock > Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0

# System Preferences > Dock > Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# System Preferences > Dock > Remove Recently Opened Applications
defaults write com.apple.dock show-recents -int 0
