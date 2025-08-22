{ config, pkgs, lib, ...}: {
  home.username = "vincent";
  home.homeDirectory = "/home/vincent";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  xsession.enable = true;

  xsession.windowManager.i3 = {
    enable = false;
  };
  
  programs.alacritty = {
    enable = true;
  };

  programs.i3status.enable = true;

  home.packages = with pkgs; [
    neovim
    go
    python314
    clang
    nodejs_24
    git
    neofetch
    firefox
  ];

  xdg.configFile."alacritty".source = ../dotfiles/alacritty;
  xdg.configFile."i3".source = ../dotfiles/i3;
  xdg.configFile."nvim".source = ../dotfiles/nvim;

}
