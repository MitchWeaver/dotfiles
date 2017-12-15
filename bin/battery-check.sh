#!/bin/bash


perc=$(cat /sys/class/power_supply/BAT0/capacity)

if [ $(cat /sys/class/power_supply/AC/online) -eq 1 ] ; then
    
    echo "🔌 $perc%"
elif [ $perc -gt 20 ] ; then
    echo "⚡ $perc%"
elif [ $perc -gt 12 ] ; then
    echo "⚡ $perc% ❗"
else 
    echo "⚡ $perc% ☠️ ❗"

fi 

