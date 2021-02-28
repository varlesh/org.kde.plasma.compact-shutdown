#!/bin/sh
rm -rf ../contents/locale/*
for f in *.po; do
mkdir -p ../contents/locale/$f/LC_MESSAGES
msgfmt $f -o ../contents/locale/$f/LC_MESSAGES/plasma_applet_org.kde.plasma.compact-shutdown.mo
done
rename s/\.po//g ../contents/locale/*
