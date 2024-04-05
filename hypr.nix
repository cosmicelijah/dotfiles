{ inputs, pkgs, ... }: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    	
      settings = {
  	  debug = {
  	    disable_logs = false;
  	    enable_stdout_logs = true;
  	  };
  
  	  exec-once = "~/snowflake/hypr/pickRandomWallpaper.sh & waybar & chromium & kitty & hyprpaper & swayidle -w timeout 600 'hyprlock'";
  
      monitor = ["eDP-1,preferred,auto,1"];
  
      input = {
       	kb_layout = "us";
       	follow_mouse = 2;
       	touchpad = {
       	  natural_scroll = true;
       	};
      };
  
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(e591b5ee) rgba(7a1330ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };
  
      decoration = {
       	rounding = 5;
       	drop_shadow = true;
       	shadow_range = 4;
       	"col.shadow" = "rgba(1a1a1aee)";
  
      	blur = {
       	  enabled = true;
       	  size = 4;
       	  passes = 2;
      	  noise = 0.01;
       	};
      };
  
      dwindle = {
       	pseudotile = true;
       	preserve_split = true;
      };
  
      master = {
       	new_is_master = true;
      };
  
      gestures = {
       	workspace_swipe = true;
       	workspace_swipe_cancel_ratio = 0.15;
      };
  
      misc = {
       	mouse_move_enables_dpms = true;
       	key_press_enables_dpms = true;
      };
  
      plugin = {
       	touch_gestures = {
       	  sensitivity = 1.0;
       	  workspace_swipe_fingers = 3;
       	  workspace_swipe_edge = "d";
       	  long_press_delay = 400;
        	  
      	};
      };
        
    };
  
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
    ];
      
  extraConfig = ''
  	${builtins.readFile ./hypr/mocha.conf}
  	${builtins.readFile ./hypr/binds.conf}
    ${builtins.readFile ./hypr/anims.conf}
    ${builtins.readFile ./hypr/windowrules.conf}
  '';
  	
  
  	
  };
}
