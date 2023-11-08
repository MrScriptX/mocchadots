{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # desktop/utils
    hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland    
    swww
    rofi-wayland
    waybar
    dunst
    cliphist
    wl-clipboard
    wineWowPackages.waylandFull

    # system
    psmisc

    # networking
    networkmanagerapplet
    blueman

    # apps
    vscode-with-extensions
    megasync    
    discord

    # tools
    kitty
    git
  ];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland = {
      enable = true;
    };
  };

  fonts.fonts = with pkgs; [
    font-awesome
    nerdfonts
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
