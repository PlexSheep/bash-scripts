#!/usr/bin/bash
alsa_in -d hw:Capture -j "Capturecard in" &
alsa_out -d hw:Capture -j "Capturecard out" &
pacmd load-module module-jack-source channels=2
