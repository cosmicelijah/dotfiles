{ pkgs, ... }:

{
  programs.bash = {
  	enable = true;

  	enableCompletion = true;

  	historyControl = "ignoredups"

  	initExtra = {
  	  "PS1='\[\e[1;33m\]{\[\e[1;31m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h\[\e[1;33m\]}-\[\e[1;33m\][\[\e[1;35m\]\w\[\e[1;33m\]]\[\e[1;37m\]\$\[\e[0;37m\] '"
      "PS2='\[\e[1;35m\]>\[\e[0;37m\] '"
	  "cat ~/.bash_header | cowsay | lolcat"
	  "shopt -s autocd"
  	};

  	profileExtra = {
  	  ". ~/.bash_aliases"
  	};
  }
}
