{ user, ... }:
{
  networking.hostName = "CALaptopG14"; # Define hostname.

  programs.rog-control-center.enable = true;
  programs.rog-control-center.autoStart = true;

  # Torchpad is so slow
  home-manager.users.${user}.dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 0.2;
    };
  };

  # Reserve one core to prevent the system from freezing
  nix.settings.cores = 15;

  imports = [
    ../../general/btrfs/autoscrub.nix
    ../../general/btrfs/snapper.nix
    ../../general/btrfs/docker.nix
    ../../general/ssd/trim.nix
    ../../general/keyboard/vamillo.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Persistent
    ./persistent.nix
    # Featrues
    ./modules/features/rathole.nix
  ];
}
