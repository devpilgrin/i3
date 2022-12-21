#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
if type "xrandr"; then
  for m in $(xrandr -q | grep " connected" | cut -d ' ' -f1 | sort -r); do 
    if [ "$m" = 'DP-5' ]; 
    then   
      MONITOR=$m polybar -c $HOME/.config/i3/polybar/config --reload top &
    elif [ "$m" = 'DP-3' ]; 
    then 
      MONITOR=$m polybar -c $HOME/.config/i3/polybar/config --reload lefttop &
    elif [ "$m" = 'DP-0' ]; 
    then 
      MONITOR=$m polybar -c $HOME/.config/i3/polybar/config --reload righttop &
    else
      MONITOR=$m polybar -c $HOME/.config/i3/polybar/config --reload top &
    fi
  done
else
  polybar -c $HOME/.config/i3/polybar/config --reload top &
fi

# polybar top &
# polybar bottom &

echo "Bars launched..."
