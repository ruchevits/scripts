#!/bin/zsh

function dock_add_app() {
    defaults write com.apple.dock $1 -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>$2</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
}

function dock_add_directory() {
    # tile-data.displayas: 0 for stack view or 1 for folder icon
    # tile-data.showas: 0 for auto, 1 for fan view, 2 for grid view or 3 for list view
    defaults write com.apple.dock $1 -array-add "<dict>
            <key>tile-type</key>
            <string>directory-tile</string>
            <key>tile-data</key>
            <dict>
                <key>file-data</key>
                <dict>
                    <key>_CFURLString</key>
                    <string>$2</string>
                    <key>_CFURLStringType</key>
                    <integer>0</integer>
                </dict>
                <key>displayas</key>
                <integer>1</integer>
                <key>showas</key>
                <integer>2</integer>
                <key>preferreditemsize</key>
                <integer>-1</integer>
            </dict>
        </dict>"
}

function dock_add_spacer() {
    # spacer-tile, small-spacer-tile, flex-spacer-tile
    defaults write com.apple.dock $1 -array-add "{\"tile-type\"=\"$2\";}"
}
