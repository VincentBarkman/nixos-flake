{ config, pkgs, lib, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "wifi-1-user-1";
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  fonts.packages = with pkgs; [ 
    nerd-fonts.bigblue-terminal 
  ];
  fonts.fontconfig.enable = true;

  networking.networkmanager.enable = true;

  console.keyMap = "sv-latin1";

  users.users.vincent = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "se";
    libinput.enable = true;

    windowManager.i3 = {
      enable = true;
      
      extraPackages = with pkgs; [
        i3status
        i3lock
        dmenu
        picom
        feh
      ];
    };
  };

  services.displayManager.ly.enable = true;

  services.picom =  {
    enable = true;
    vSync = true;
    fade = false;
    shadow = false;
  };

  home-manager.backupFileExtension = "hm-bak";

  system.stateVersion = "25.05";
}
