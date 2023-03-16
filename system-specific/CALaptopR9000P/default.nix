{ ... }:
{
  networking.hostName = "CALaptopR9000P"; # Define hostname.

  imports = [
    # ./modules/features/rathole
    ./modules/features/gpu-paththrough
  ];

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';
}