max=$(ls ~/wallpaper/videos | wc -l)
random1=$((RANDOM % max + 1))
random2=$((RANDOM % max + 1))
counter1=1
counter2=1

if pgrep -x "gslapper"; then
    killall gslapper
fi

for i in $(ls ~/wallpaper/videos); do
    if [[ counter1 -eq random1 ]]; then
        gslapper -s -o "no-audio loop" DP-1 ~/wallpaper/videos/$i &
    fi
    counter1=$((counter1 + 1))
    if [[ counter2 -eq random2 ]]; then
        gslapper -s -o "no-audio loop" DP-2 ~/wallpaper/videos/$i &
    fi
    counter2=$((counter2 + 1))
done
