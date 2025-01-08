{ user, ... }:
{
  networking.hostName = "CALaptopR9000P"; # Define hostname.

  # Reserve one core to prevent the system from freezing
  nix.settings.cores = 15;

  # Do less swapping instead of droping page cache (default=60)
  # boot.kernel.sysctl."vm.swappiness" = 30;

  # https://nixos.org/manual/nixos/unstable/index.html#sec-gpu-accel-vulkan
  # environment.variables.DXVK_FILTER_DEVICE_NAME = "NVIDIA GeForce RTX 3060 Laptop GPU";

  imports = [
    ../../general/btrfs/autoscrub.nix
    ../../general/btrfs/snapper.nix
    ../../general/btrfs/docker.nix
    ../../general/ssd/trim.nix
    ../../general/keyboard/vamillo.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../general/linux/tpm2.nix
    ../../general/linux/zswap.nix
    # Persistent
    ./persistent.nix
  ];
}
