#!/bin/sh

xrandr
xrdb -merge ~/.Xresources

# Fire it up
exec dbus-launch bspwm
