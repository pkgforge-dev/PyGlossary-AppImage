#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q pyglossary | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/pyglossary.svg
export DESKTOP=/usr/share/applications/pyglossary.desktop
export DEPLOY_SYS_PYTHON=1
export DEPLOY_GTK=1
export GTK_DIR=gtk-3.0
export DEPLOY_LOCALE=1

# Deploy dependencies
quick-sharun \
	/usr/bin/pyglossary*   \
	/usr/share/pyglossary  \
	/usr/lib/libgirepository*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
