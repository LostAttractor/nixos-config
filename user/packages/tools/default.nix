{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    hyfetch
    screenfetch
    cmatrix
    ffmpeg_5-full
    virt-manager
    fsearch
    fragments
    you-get
    handlr
    xdotool
    nmap
    rustdesk
    parsec-bin
    looking-glass-client
    powertop
    flameshot
    wgcf
    uxplay
  ];

  imports = [
    ./rime
    ./alacritty
    ./landrop
  ];
}