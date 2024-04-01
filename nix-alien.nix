{ inputs, pkgs, ... }: 
{
  imports = [ inputs.nix-alien.packages.${pkgs} ];

  home.packages = [ 
  	nix-alien
  ];

  programs.nix-alien = {
  	enable = true;
  };
  
}
