# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

# Different one

{ config, inputs, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
      (self: super: {
        steam-run = (super.steam.override {
          extraLibraries = pkgs: with pkgs;
            [
              ncurses5
            ];
        }).run;
      })
    ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda1";

  # Add mount options to subvols
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  # Hostname
  networking.hostName = "HoloOS";
 
  # Networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  ## ----------------= Env Variables =-------------------

  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
  	XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    MOZ_ENABLE_WAYLAND = "1";

  	
  };


  ## -------------------= Hardware =----------------------

  programs.light.enable = true;
  zramSwap.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      ncurses5
      glibc
      zlib
    ];
  };

  ## ----------------= XServer Services =-----------------

  services.xserver = {

    # Enable xserver
    enable = true;
    
    # NoVideo drivers
    # videoDrivers = [ "nvidia" ];

    # Display Manager
    displayManager.gdm = {
      
      # Enable GDM
      enable = true;
 
      # Enable GDM Wayland
      wayland = true;
    };

    # Keymap
    xkb.layout = "us";
  };

  ## ----------------= Audio =------------------

  services.pipewire = {
    enable = true;
    
    alsa.enable = true;

    pulse.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  
  ## -------------= User Account =--------------

  users.users.cosmicelijah = {
    initialPassword = "1234";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
  	extraSpecialArgs = { inherit inputs; };
  	users = {
  	  "cosmicelijah" = import ./home.nix;
  	};
  };

  ## ---------------------= Packages =----------------------

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Neofetch is REQUIRED for system to boot
    neofetch

    # Text editor
    micro # NixOS' default

    # Fetch things from remote places
    wget
    git
    
    # Audio
    pipewire
    wireplumber

    # Hardware utils
    usbutils
    pciutils

    dbus
    nix-index

    ncurses5
    steam-run

    # steam-run = (super.steam.override {
    #   extraLibraries = pkgs:
    #     [ (pkgs.sndio.overrideAttrs (old: { version = "6.1"; })) ];
    # }).run;

    
    # (steam.override { extraPkgs = pkgs: [ at-spi2-atk openssl_1_0_2 ]; nativeOnly = false; }).run
  ];

  ## ----------------------- Hyprland -------------------------

  programs.hyprland = {
  	enable = true;
  	package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  ## ---------------------= Swaylock =------------------------

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

