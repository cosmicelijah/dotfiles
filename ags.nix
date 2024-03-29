{ inputs, pkgs, ... }: 
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [ 
  	pkgs.ydotool 
  	pkgs.dart-sass 
  	pkgs.gnome.gnome-control-center 
  	pkgs.blueberry pkgs.playerctl 
  	pkgs.python3 
  	pkgs.python311Packages.material-color-utilities 
  	pkgs.gtksourceview 
  ];

  programs.ags = {
  	enable = true;

    configDir = null;

    extraPackages = [
  	  pkgs.libsoup_3
  	  pkgs.gtksourceview
    ];
  };
  
}
