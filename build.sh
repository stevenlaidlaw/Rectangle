#!/bin/zsh

function echo_color() {
  local color=$1
  local text=$2
  echo "\033[${color}m${text}\033[0m"
}

echo_color "31" "Killing any instances"
killall Rectangle

echo_color "31" "Removing old app"
rm -rf "/Applications/Rectangle.app"

echo_color "32" "Building"
xcodebuild -project "Rectangle.xcodeproj" -scheme "Rectangle" -configuration "Debug" -derivedDataPath "build"

echo_color "32" "Copying to /Applications"
cp -R "build/Build/Products/Debug/Rectangle.app" "/Applications/"

echo_color "34" "Signing app"
sudo codesign --force --deep --sign - "/Applications/Rectangle.app"

echo_color "34" "Resetting Accessibility permissions"
tccutil reset Accessibility com.knollsoft.Rectangle

# echo_color "34" "Setting preferences"
# defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0

echo_color "33" "Opening Rectangle"
open "/Applications/Rectangle.app"

echo_color "33" "Opening Accessibility preferences"
open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
