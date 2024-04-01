{ config, pkgs, inputs, ... }:

let 
  # To keep wallpapers consistent across all the different hypr shit
  wallpaperPath = "~/.config/hypr/wallpaper.png";

  # Import variables
  hyprConfig = import ./hypr.nix { inherit inputs pkgs; };
  agsConfig = import ./ags.nix { inherit inputs pkgs; };
  hyprlockConfig = import ./hyprlock.nix { inherit wallpaperPath; };
  hyprpaperConfig = import ./hyprpaper.nix { inherit wallpaperPath; };
  bashConfig = import ./bash.nix { inherit pkgs; };
in {
  # Make Richard Stallman mad
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  
  home.username = "cosmicelijah";
  home.homeDirectory = "/home/cosmicelijah";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.


  imports = [ 
    hyprConfig
    agsConfig
    hyprlockConfig
    hyprpaperConfig
    bashConfig
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    
    # Terminal Commands
    pkgs.lolcat
    pkgs.cowsay
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.btop
    pkgs.tree

    # GUI Applications
    pkgs.firefox
    pkgs.webcord
    pkgs.gimp
    pkgs.electron
    pkgs.vscode
    pkgs.xfce.thunar
    pkgs.feh

    # Desktop Stuff
    pkgs.hyprpaper
    pkgs.kitty
    pkgs.wofi
    pkgs.waybar
    pkgs.swayidle
    pkgs.dunst
    pkgs.hyprlock

    # Development Stuff
    pkgs.python3
    pkgs.nodejs
    pkgs.jdk
    pkgs.gcc

    pkgs.steam-run
  	
	
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cosmicelijah/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "micro";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
