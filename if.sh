#! /bin/sh

while true; do ifconfig  | sed -f if.sed; sleep 1; clear; done
