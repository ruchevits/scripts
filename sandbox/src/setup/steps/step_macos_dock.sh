#!/bin/bash

function step_macos_dock() {

    # Configure dock (https://developer.apple.com/documentation/devicemanagement/dock)

    defaults delete com.apple.dock

    defaults write com.apple.dock orientation -string bottom
    defaults write com.apple.dock tilesize -integer 64

    defaults write com.apple.dock size-immutable -bool true
    defaults write com.apple.dock position-immutable -bool true
    defaults write com.apple.dock contents-immutable -bool true
    defaults write com.apple.dock showrecents-immutable -bool true

    defaults write com.apple.dock static-only -bool true
    defaults write com.apple.dock show-recents -bool false

    defaults write com.apple.dock static-apps -array
    defaults write com.apple.dock static-others -array
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-others -array

    dock_add_app static-apps "/Applications/Spotify.app"
    # dock_add_app static-apps "/Applications/VLC.app"

    # dock_add_spacer static-apps flex-spacer-tile
    dock_add_spacer static-apps spacer-tile

    dock_add_app static-apps "/Applications/Utilities/iTerm.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Google Chrome.app"
    dock_add_app static-apps "/Applications/Firefox.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Notion Calendar.app"
    dock_add_app static-apps "/Applications/Notion.app"
    dock_add_app static-apps "/Applications/Slack.app"
    dock_add_app static-apps "/Applications/Telegram.app"
    dock_add_app static-apps "/Applications/Figma.app"

    dock_add_spacer static-apps small-spacer-tile

    dock_add_app static-apps "/Applications/Postico 2.app"
    dock_add_app static-apps "/Applications/RapidAPI.app"
    dock_add_app static-apps "/Applications/Visual Studio Code.app"

    # dock_add_spacer static-apps flex-spacer-tile
    dock_add_spacer static-apps spacer-tile

    dock_add_directory static-others /Users/johndoe/Downloads/
    # dock_add_directory static-others "/Users/johndoe/Library/CloudStorage/GoogleDrive-ruchevits@gmail.com"
    # dock_add_directory static-others "/Users/johndoe/Library/CloudStorage/GoogleDrive-edward@ruchevits.com"

    # Mission Control
    defaults write com.apple.dock "mru-spaces" -bool "false"

    killall Dock
}
