{ wallpaperPath, ... }: 

{
  

  xdg.configFile."hypr/hyprpaper.conf" = {
    enable = true;

    text = ''
    preload = ${wallpaperPath}
    wallpaper = eDP-1, ${wallpaperPath}
    splash = true
	'';
  };
}

