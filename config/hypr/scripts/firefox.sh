#!/bin/bash

hyprctl dispatch movetoworkspacesilent 2,"class:firefox,title:^(\[fx_main\])"
hyprctl dispatch movetoworkspacesilent 2,"class:firefox,title:^(\[fx_search\])"
hyprctl dispatch movetoworkspacesilent 3,"class:firefox,title:^(\[fx_eks\])"
hyprctl dispatch movetoworkspacesilent 7,"class:firefox,title:^(\[fx_superset\])"
hyprctl dispatch movetoworkspacesilent 8,"class:firefox,title:^(\[fx_rust\])"
hyprctl dispatch movetoworkspacesilent 8,"class:firefox,title:^(\[fx_chatgpt\])"

hyprctl dispatch movetoworkspacesilent 10,"class:(vivaldi-stable),title:^(My Recorder)"
