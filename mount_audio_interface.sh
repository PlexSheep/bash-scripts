#!/usr/bin/bash
alsa_in -d hw:CODEC -j "CODEC audio interface in" &
alsa_out -d hw:CODEC -j "CODEC audio interface out" &
