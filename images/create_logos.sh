#!/bin/bash

convert -resize 108x69  rlocal_icon_focus_hd.png rlocal_icon_side_hd.png
convert -resize 248x140 rlocal_icon_focus_hd.png rlocal_icon_focus_sd.png
convert -resize 80x46   rlocal_icon_focus_hd.png rlocal_icon_side_sd.png

convert -resize 149x45 logo_overhang_rlocal_movies_HD.png logo_overhang_rlocal_movies_SD.png
