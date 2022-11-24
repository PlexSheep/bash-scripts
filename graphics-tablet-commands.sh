#!/bin/bash
# list wacom devices
xsetwacom --list devices

# man xsetwacom:
# MapToOutput [output]
# Users of the NVIDIA binary driver should use the output names "HEAD-0" and "HEAD-1" until the driver supports XRandR 1.2 or later.

# sets the pen to only use main screen
xsetwacom  set "HUION Huion Tablet_H580X stylus" MapToOutput HEAD-0     
xsetwacom  set "HUION Huion Tablet_H580X Pen stylus" MapToOutput HEAD-0     

# map buttons:
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 1  "key ctrl shift p"	# first button, first of upper triad, xournal pen
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 2  "key ctrl shift h"	# second button, mid of upper triad, xournal highlighter
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 3  "key ctrl 6"	# third button, last of upper triad, xournal line
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 8  "key ctrl +"	# fourth button, first of mid circle, zoom+
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 9  "key ctrl -"	# fifth button, last of mid circle, zoom-
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 10  "key ctrl PgUp"	# sixth button, first of lower triad, next page
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 11  "key ctrl PgDn"	# seventh button, mid of lower triad, prev. page
xsetwacom  set "HUION Huion Tablet_H580X Pad pad" button 12  "key ctrl z"	# eigth button, last of lower triad, undo

# wacom tablet button numbering from top to bottom, including the two middle keys:
# first is 1	-
# second is 2	-
# third is 3	-
# fourth is 8	o upper
# fifth is 9	o lower
# sixth is 10	-
# seventh is 11	-
# eigth is 12	-
