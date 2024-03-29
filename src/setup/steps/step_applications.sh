#!/bin/bash

function step_applications() {
    brew_install_cask spotify "/Applications"
    BREW_INSTALLED_SPOTIFY=$?

    brew_install_cask vlc "/Applications"
    BREW_INSTALLED_VLC=$?

    brew_install_cask google-chrome "/Applications"
    BREW_INSTALLED_GOOGLE_CHROME=$?

    brew_install_cask firefox "/Applications"
    BREW_INSTALLED_FIREFOX=$?

    brew_install_cask google-drive "/Applications"
    BREW_INSTALLED_GOOGLE_DRIVE=$?

    brew_install_cask notion "/Applications"
    BREW_INSTALLED_NOTION=$?

    brew_install_cask notion-calendar "/Applications"
    BREW_INSTALLED_NOTION_CALENDAR=$?

    brew_install_cask slack "/Applications"
    BREW_INSTALLED_SLACK=$?

    brew_install_cask telegram "/Applications"
    BREW_INSTALLED_TELEGRAM=$?

    brew_install_cask figma "/Applications"
    BREW_INSTALLED_FIGMA=$?

    brew_install_cask postico "/Applications"
    BREW_INSTALLED_POSTICO=$?

    brew_install_cask rapidapi "/Applications"
    BREW_INSTALLED_RAPIDAPI=$?

    brew_install_cask visual-studio-code "/Applications"
    BREW_INSTALLED_VSCODE=$?

    brew_install_cask hammerspoon "/Applications/Utilities"
    BREW_INSTALLED_HAMMERSPOON=$?

    # Force cleanup
    brew_cleanup 1
}
