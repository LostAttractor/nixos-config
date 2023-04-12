{ user, ... }:
{
  networking.hostName = "CALaptopG14"; # Define hostname.

  programs.rog-control-center.enable = true;
  programs.rog-control-center.autoStart = true;

  services.asusd.enable = true;

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  home-manager.users.${user}.dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.2;
    };
  };

  imports = [
    ./modules/nix/access-tokens
    ./modules/nix/remote-build
    ./modules/features/luks
    ./modules/features/rathole
    ./modules/features/wireguard
    ./modules/features/virtualisation
    ./modules/features/gpu-paththrough
  ];
}