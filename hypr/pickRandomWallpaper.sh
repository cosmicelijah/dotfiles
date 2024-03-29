files=(~/snowflake/hypr/wallpapers/*)

rm ~/.config/hypr/wallpaper.png

wp=${files[RANDOM % ${#files[@]}]}

ln -s $wp ~/.config/hypr/wallpaper.png
