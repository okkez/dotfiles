#!/bin/bash

swayidle -w \
         timeout 900 'swaylock -f -c 002b36ff' \
         timeout 1800 'systemctl suspend' \
         before-sleep 'swaylock -f -c 002b36ff' &
